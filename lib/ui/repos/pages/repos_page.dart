import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/common_widgets/common_widget.dart';
import 'package:flutter_template/ui/repos/bloc/repos_cubit.dart';
import 'package:flutter_template/ui/repos/widgets/repo_item.dart';

class ReposPage extends StatefulWidget {
  const ReposPage({super.key});

  @override
  State<StatefulWidget> createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  final _scrollController = ScrollController();
  final _reposCubit = ReposCubit();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _reposCubit.fetchRepos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Repos',
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: _renderListRepos(),
      ),
    );
  }

  Widget _renderListRepos() {
    return BlocBuilder<ReposCubit, ReposState>(
      bloc: _reposCubit,
      builder: (context, state) {
        return state.when(
          initial: () {
            return const SizedBox.shrink();
          },
          loading: () {
            return const BottomLoader();
          },
          success: (repos, page, hasReachedMax) {
            if (repos.isEmpty == true) {
              return const Center(child: Text('no repos'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                _reposCubit.reloadRepos();
              },
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return index >= repos.length ? const BottomLoader() : RepoItem(repo: repos[index]);
                },
                itemCount: hasReachedMax ? repos.length : repos.length + 1,
                controller: _scrollController,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 8);
                },
              ),
            );
          },
          fail: (message) {
            return Center(child: Text(message));
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _reposCubit.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _reposCubit.fetchRepos();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
