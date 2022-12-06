import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/repositories/user_repository.dart';
import 'package:flutter_template/user_details/models/user_details.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../services/services.dart';

part 'user_details_event.dart';

part 'user_details_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  late UserRepository _repository;

  UserDetailsBloc() : super(const UserDetailsState()) {
    _repository = UserRepository();
    on<UserDetailsFetch>(
      _onUserDetailsFetch,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onUserDetailsFetch(UserDetailsEvent event, Emitter<UserDetailsState> emit) async {
    try {
      if (state.status != UserDetailsStatus.loading) {
        emit(state.copyWith(status: UserDetailsStatus.loading));
        final userDetails = await _fetchUserDetails();
        return emit(
          state.copyWith(
            status: UserDetailsStatus.success,
            userDetails: userDetails,
          ),
        );
      }
    } on AppException catch (appException) {
      emit(state.copyWith(status: UserDetailsStatus.failure, errMessage: appException.message));
    } catch (error) {
      emit(state.copyWith(status: UserDetailsStatus.failure, errMessage: error.toString()));
    }
  }

  Future<UserDetails> _fetchUserDetails() async {
    final userDetails = _repository.fetchUserDetails();
    return userDetails;
  }
}
