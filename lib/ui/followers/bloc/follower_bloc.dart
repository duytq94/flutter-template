import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/di/app_injection.dart';
import 'package:flutter_template/repositories/follower_repository.dart';
import 'package:flutter_template/services/result_model.dart';
import 'package:stream_transform/stream_transform.dart';

import '../models/follower.dart';

part 'follower_event.dart';

part 'follower_state.dart';

const perPage = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  FollowerBloc() : super(FollowerInitial()) {
    on<FollowerFetch>(
      _onFollowerFetch,
      transformer: throttleDroppable(throttleDuration),
    );
    on<FollowerReload>(
      _onFollowerReload,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onFollowerFetch(FollowerFetch event, Emitter<FollowerState> emit) async {
    var currentState = state;
    if (_hasReachMax(currentState)) return;

    if (currentState is! FollowerSuccess) {
      emit(FollowerLoading());
      var res = await _fetchFollowers(1);
      if (res is Success<List<Follower>>) {
        var followers = res.data;
        return emit(
          FollowerSuccess(
            followers: followers,
            page: 1,
            hasReachedMax: followers.length < perPage,
          ),
        );
      } else if (res is Failure) {
        emit(FollowerFail(res.errMessage));
      }
    } else {
      // load more
      final res = await _fetchFollowers(currentState.page);
      if (res is Success<List<Follower>>) {
        var followers = res.data;
        emit(
          followers.isEmpty
              ? currentState.copyWith(hasReachMax: true)
              : currentState.copyWith(
                  followers: [...currentState.followers, ...followers],
                  hasReachMax: false,
                  page: currentState.page + 1,
                ),
        );
      } else if (res is Failure) {}
    }
  }

  Future<void> _onFollowerReload(FollowerReload event, Emitter<FollowerState> emit) async {
    emit(FollowerLoading());
    var res = await _fetchFollowers(1);
    if (res is Success<List<Follower>>) {
      var followers = res.data;
      emit(
        FollowerSuccess(
          followers: followers,
          page: 1,
          hasReachedMax: followers.length < perPage,
        ),
      );
    } else if (res is Failure) {
      emit(FollowerFail(res.errMessage));
    }
  }

  Future<Result> _fetchFollowers(int page) async {
    final result = getIt.get<FollowerRepository>().getFollowers(page, perPage);
    return result;
  }

  bool _hasReachMax(FollowerState state) {
    return state is FollowerSuccess && state.hasReachedMax == true;
  }
}
