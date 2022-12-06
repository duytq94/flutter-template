part of 'user_details_bloc.dart';

enum UserDetailsStatus { initial, loading, success, failure }

class UserDetailsState extends Equatable {
  const UserDetailsState({
    this.status = UserDetailsStatus.initial,
    this.userDetails,
    this.errMessage,
  });

  final UserDetailsStatus status;
  final UserDetails? userDetails;
  final String? errMessage;

  UserDetailsState copyWith({
    UserDetailsStatus? status,
    UserDetails? userDetails,
    String? errMessage,
  }) {
    return UserDetailsState(
      status: status ?? this.status,
      userDetails: userDetails ?? this.userDetails,
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  String toString() {
    return '''UserDetailsState { status: $status, userDetails: $userDetails, errMessage: $errMessage }''';
  }

  @override
  List<Object?> get props => [status, userDetails];
}
