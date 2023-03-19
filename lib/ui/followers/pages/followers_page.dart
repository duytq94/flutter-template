import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/common_widgets/common_button.dart';
import 'package:flutter_template/ui/followers/bloc/follower_bloc.dart';
import 'package:flutter_template/common/common_widgets/bottom_loader.dart';
import 'package:flutter_template/ui/followers/widgets/follower_item.dart';

class FollowerPage extends StatefulWidget {
  const FollowerPage({Key? key}) : super(key: key);

  @override
  State<FollowerPage> createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  final _scrollController = ScrollController();
  late FollowerBloc _followerBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _followerBloc = FollowerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            const SizedBox(height: 10),
            _renderCtaBtn(),
            const SizedBox(height: 10),
            _renderListFollowers(),
          ],
        ),
      ),
    );
  }

  Widget _renderCtaBtn() {
    return Center(
      child: CommonButton(
        onPress: () {
          _followerBloc.add(FollowerFetch());
        },
        text: "Get followers",
      ),
    );
  }

  Widget _renderListFollowers() {
    return Expanded(
      child: BlocProvider(
        create: (_) => _followerBloc,
        child: BlocBuilder<FollowerBloc, FollowerState>(
          builder: (context, state) {
            if (state is FollowerFail) {
              return Center(child: Text(state.errMessage));
            }
            if (state is FollowerSuccess) {
              if (state.followers.isEmpty == true) {
                return const Center(child: Text('no followers'));
              }
              var followers = state.followers;
              return RefreshIndicator(
                onRefresh: () async {
                  _followerBloc.add(FollowerReload());
                },
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= followers.length ? const BottomLoader() : FollowerItem(follower: followers[index]);
                  },
                  itemCount: state.hasReachedMax ? followers.length : followers.length + 1,
                  controller: _scrollController,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8);
                  },
                ),
              );
            }
            if (state is FollowerInitial) {
              return const SizedBox.shrink();
            }
            if (state is FollowerLoading) {
              return const BottomLoader();
            }
            return const Center(child: Text("Undefined state"));
          },
        ),
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
    if (_isBottom) _followerBloc.add(FollowerFetch());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
