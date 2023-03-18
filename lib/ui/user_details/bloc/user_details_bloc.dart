import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/di/app_injection.dart';
import 'package:flutter_template/repositories/user_details_repository.dart';
import 'package:flutter_template/services/result_model.dart';
import 'package:flutter_template/ui/user_details/models/user_details.dart';
import 'package:stream_transform/stream_transform.dart';

part 'user_details_event.dart';

part 'user_details_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(UserDetailsInitial()) {
    on<FetchUserDetails>(
      _onUserDetailsFetch,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onUserDetailsFetch(UserDetailsEvent event, Emitter<UserDetailsState> emit) async {
    if (state is! UserDetailsLoading) {
      emit(UserDetailsLoading());
      final res = await getIt.get<UserDetailsRepository>().getUserDetails();
      if (res is Success<UserDetails>) {
        emit(UserDetailsSuccess(res.data));
      } else if (res is Failure) {
        emit(UserDetailsFail(res.errMessage));
      }
    }
  }
}
