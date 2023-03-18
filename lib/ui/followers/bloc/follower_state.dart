part of 'follower_bloc.dart';

class FollowerState extends Equatable {
  const FollowerState();

  @override
  List<Object?> get props => [];
}

class FollowerInitial extends FollowerState {}

class FollowerLoading extends FollowerState {}

class FollowerSuccess extends FollowerState {
  final List<Follower> followers;
  final int page;
  final bool hasReachedMax;

  const FollowerSuccess({
    required this.followers,
    required this.page,
    required this.hasReachedMax,
  });

  FollowerSuccess copyWith({List<Follower>? followers, int? page, bool? hasReachMax}) {
    return FollowerSuccess(
      followers: followers ?? this.followers,
      page: page ?? this.page,
      hasReachedMax: hasReachMax ?? hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [followers, page, hasReachedMax];

  @override
  String toString() {
    return 'FollowerSuccess { followers: $followers, page: $page, hasReachedMax: $hasReachedMax }';
  }
}

class FollowerFail extends FollowerState {
  final String errMessage;

  const FollowerFail(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
