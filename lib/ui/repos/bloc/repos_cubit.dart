import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/di/app_injection.dart';
import 'package:flutter_template/repositories/repo_repository.dart';
import 'package:flutter_template/services/result_model.dart';
import 'package:flutter_template/ui/repos/bloc/repos_state.dart';
import 'package:flutter_template/ui/repos/models/repo.dart';

class ReposCubit extends Cubit<ReposState> {
  final perPage = 10;

  ReposCubit() : super(ReposInitial());

  void fetchRepos() async {
    var currentState = state;
    if (_hasReachMax(currentState)) return;

    if (currentState is! ReposSuccess) {
      emit(ReposLoading());
      final res = await getIt.get<RepoRepository>().getRepos(1, perPage);
      if (res is Success<List<Repo>>) {
        var repos = res.data;
        emit(ReposSuccess(repos: repos, currentPage: 1, hasReachedMax: repos.length < perPage));
      } else if (res is Failure) {
        emit(ReposFail(res.errMessage));
      }
    } else {
      // load more
      final res = await getIt.get<RepoRepository>().getRepos(currentState.currentPage + 1, perPage);
      if (res is Success<List<Repo>>) {
        var repos = res.data;
        emit(
          repos.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : currentState.copyWith(
                  repos: [...currentState.repos, ...repos],
                  currentPage: currentState.currentPage + 1,
                  hasReachedMax: repos.length < perPage,
                ),
        );
      } else if (res is Failure) {
        emit(ReposFail(res.errMessage));
      }
    }
  }

  void reloadRepos() async {
    emit(ReposLoading());
    final res = await getIt.get<RepoRepository>().getRepos(1, perPage);
    if (res is Success<List<Repo>>) {
      var repos = res.data;
      emit(ReposSuccess(repos: repos, currentPage: 1, hasReachedMax: repos.length < perPage));
    } else if (res is Failure) {
      emit(ReposFail(res.errMessage));
    }
  }

  bool _hasReachMax(ReposState state) {
    return state is ReposSuccess && state.hasReachedMax == true;
  }
}
