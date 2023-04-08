part of 'repos_cubit.dart';

@freezed
class ReposState with _$ReposState {
  const factory ReposState.initial() = _Initial;

  const factory ReposState.loading() = _Loading;

  const factory ReposState.success({
    required List<Repo> repos,
    required int currentPage,
    required bool hasReachedMax,
  }) = _Success;

  const factory ReposState.fail(String message) = _Fail;
}
