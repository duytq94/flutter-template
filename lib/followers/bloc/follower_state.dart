part of 'follower_bloc.dart';

enum FollowerStatus { initial, loading, success, failure }

class FollowerState extends Equatable {
  const FollowerState({
    this.status = FollowerStatus.initial,
    this.followers,
    this.hasReachedMax = false,
    this.page = 1,
    this.errMessage = "",
  });

  final FollowerStatus status;
  final List<Follower>? followers;
  final bool hasReachedMax;
  final int page;
  final String errMessage;

  FollowerState copyWith({
    FollowerStatus? status,
    List<Follower>? followers,
    bool? hasReachedMax,
    int? page,
    String? errMessage,
  }) {
    return FollowerState(
      status: status ?? this.status,
      followers: followers ?? this.followers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      errMessage: errMessage ?? this.errMessage,
    );
  }

  @override
  String toString() {
    return '''FollowerState { status: $status, hasReachedMax: $hasReachedMax, posts: ${followers?.length}, page: $page, errMessage: $errMessage }''';
  }

  @override
  List<Object?> get props => [status, followers, hasReachedMax];
}
