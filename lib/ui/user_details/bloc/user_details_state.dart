part of 'user_details_bloc.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object?> get props => [];
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsSuccess extends UserDetailsState {
  final UserDetails userDetails;

  const UserDetailsSuccess(this.userDetails);

  @override
  String toString() {
    return 'UserDetailsSuccess { $userDetails }';
  }

  @override
  List<Object?> get props => [userDetails];
}

class UserDetailsFail extends UserDetailsState {
  final String errMessage;

  const UserDetailsFail(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
