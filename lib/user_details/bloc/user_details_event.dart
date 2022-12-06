part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserDetailsFetch extends UserDetailsEvent {}
