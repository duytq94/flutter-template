import 'package:equatable/equatable.dart';
import 'package:flutter_template/ui/repos/models/repo.dart';

abstract class ReposState extends Equatable {
  const ReposState();

  @override
  List<Object?> get props => [];
}

class ReposInitial extends ReposState {}

class ReposLoading extends ReposState {}

class ReposFail extends ReposState {
  final String errMessage;

  const ReposFail(this.errMessage);
}

class ReposSuccess extends ReposState {
  final List<Repo> repos;
  final int currentPage;
  final bool hasReachedMax;

  const ReposSuccess({
    required this.repos,
    required this.currentPage,
    required this.hasReachedMax,
  });

  ReposSuccess copyWith({List<Repo>? repos, int? currentPage, bool? hasReachedMax}) {
    return ReposSuccess(
      repos: repos ?? this.repos,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [repos, currentPage, hasReachedMax];

  @override
  String toString() {
    return 'ReposSuccess { repos: $repos, page: $currentPage, hasReachedMax: $hasReachedMax }';
  }
}
