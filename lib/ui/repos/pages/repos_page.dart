import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/common_widgets/common_widget.dart';
import 'package:flutter_template/ui/repos/bloc/repos_cubit.dart';
import 'package:flutter_template/ui/repos/bloc/repos_state.dart';
import 'package:flutter_template/ui/repos/widgets/repo_item.dart';

class ReposPage extends StatefulWidget {
  const ReposPage({super.key});

  @override
  State<StatefulWidget> createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  final _scrollController = ScrollController();
  late ReposCubit _reposCubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _reposCubit = ReposCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Repos',
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            const SizedBox(height: 10),
            _renderCtaBtn(),
            const SizedBox(height: 10),
            _renderListRepos(),
          ],
        ),
      ),
    );
  }

  Widget _renderCtaBtn() {
    return Center(
      child: CommonButton(
        onPress: () {
          _reposCubit.fetchRepos();
        },
        text: "Get repos",
      ),
    );
  }

  Widget _renderListRepos() {
    return Expanded(
      child: BlocBuilder<ReposCubit, ReposState>(
        bloc: _reposCubit,
        builder: (context, state) {
          if (state is ReposFail) {
            return Center(child: Text(state.errMessage));
          }
          if (state is ReposSuccess) {
            var repos = state.repos;
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
                itemCount: state.hasReachedMax ? repos.length : repos.length + 1,
                controller: _scrollController,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 8);
                },
              ),
            );
          }
          if (state is ReposInitial) {
            return const SizedBox.shrink();
          }
          if (state is ReposLoading) {
            return const BottomLoader();
          }
          return const Center(child: Text("Undefined state"));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
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
