import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/di/app_injection.dart';
import 'package:flutter_template/repositories/repo_repository.dart';
import 'package:flutter_template/services/result_model.dart';
import 'package:flutter_template/ui/repos/models/repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repos_cubit.freezed.dart';

part 'repos_state.dart';

class ReposCubit extends Cubit<ReposState> {
  final _perPage = 10;

  ReposCubit() : super(const ReposState.initial());

  void fetchRepos() async {
    state.when(
      initial: () async {
        emit(const ReposState.loading());
        final res = await getIt.get<RepoRepository>().getRepos(1, _perPage);
        if (res is Success<List<Repo>>) {
          var repos = res.data;
          emit(ReposState.success(repos: repos, currentPage: 1, hasReachedMax: repos.length < _perPage));
        } else if (res is Failure) {
          emit(ReposState.fail(res.errMessage));
        }
      },
      loading: () {},
      success: (repos, currentPage, hasReachedMax) async {
        // load more
        if (hasReachedMax) return;
        final res = await getIt.get<RepoRepository>().getRepos(currentPage + 1, _perPage);
        if (res is Success<List<Repo>>) {
          var newRepos = res.data;
          emit(
            newRepos.isEmpty
                ? ReposState.success(repos: repos, currentPage: currentPage, hasReachedMax: true)
                : ReposState.success(
                    repos: [...repos, ...newRepos],
                    currentPage: currentPage + 1,
                    hasReachedMax: newRepos.length < _perPage,
                  ),
          );
        } else if (res is Failure) {
          emit(ReposState.fail(res.errMessage));
        }
      },
      fail: (message) {},
    );
  }

  void reloadRepos() async {
    emit(const ReposState.loading());
    state.maybeWhen(
      orElse: () async {
        final res = await getIt.get<RepoRepository>().getRepos(1, _perPage);
        if (res is Success<List<Repo>>) {
          var repos = res.data;
          emit(ReposState.success(repos: repos, currentPage: 1, hasReachedMax: repos.length < _perPage));
        } else if (res is Failure) {
          emit(ReposState.fail(res.errMessage));
        }
      },
    );
  }
}
