import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/repositories/follower_repository.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../services/services.dart';
import '../models/follower.dart';

part 'follower_event.dart';

part 'follower_state.dart';

const _followerLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  late FollowerRepository _repository;

  FollowerBloc() : super(const FollowerState()) {
    _repository = FollowerRepository();
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
    if (state.hasReachedMax) return;
    try {
      if (state.status == FollowerStatus.initial) {
        emit(state.copyWith(status: FollowerStatus.loading));
        final followers = await _fetchFollowers(state.page);
        return emit(
          state.copyWith(
            status: FollowerStatus.success,
            followers: followers,
            hasReachedMax: false,
            page: state.page + 1,
          ),
        );
      }
      final followers = await _fetchFollowers(state.page);
      emit(
        followers.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: FollowerStatus.success,
                followers: [...(state.followers ?? []), ...followers],
                hasReachedMax: false,
                page: state.page + 1,
              ),
      );
    } on AppException catch (appException) {
      emit(state.copyWith(status: FollowerStatus.failure, errMessage: appException.message));
    } catch (error) {
      emit(state.copyWith(status: FollowerStatus.failure, errMessage: error.toString()));
    }
  }

  Future<void> _onFollowerReload(FollowerReload event, Emitter<FollowerState> emit) async {
    try {
      emit(state.copyWith(status: FollowerStatus.loading));
      final followers = await _fetchFollowers(1);
      return emit(
        followers.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: FollowerStatus.success,
                followers: followers,
                hasReachedMax: false,
                page: state.page + 1,
              ),
      );
    } on AppException catch (appException) {
      emit(state.copyWith(status: FollowerStatus.failure, errMessage: appException.message));
    } catch (error) {
      emit(state.copyWith(status: FollowerStatus.failure, errMessage: error.toString()));
    }
  }

  Future<List<Follower>> _fetchFollowers(int page) async {
    final followers = _repository.fetchFollowers(page, _followerLimit);
    return followers;
  }
}
