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
  final int currentPage;
  final bool hasReachedMax;

  const FollowerSuccess({
    required this.followers,
    required this.currentPage,
    required this.hasReachedMax,
  });

  FollowerSuccess copyWith({List<Follower>? followers, int? currentPage, bool? hasReachedMax}) {
    return FollowerSuccess(
      followers: followers ?? this.followers,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [followers, currentPage, hasReachedMax];

  @override
  String toString() {
    return 'FollowerSuccess { followers: $followers, page: $currentPage, hasReachedMax: $hasReachedMax }';
  }
}

class FollowerFail extends FollowerState {
  final String errMessage;

  const FollowerFail(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
