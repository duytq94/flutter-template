import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/common_widgets/common_button.dart';
import 'package:flutter_template/followers/bloc/follower_bloc.dart';
import 'package:flutter_template/followers/widgets/bottom_loader.dart';
import 'package:flutter_template/followers/widgets/follower_item.dart';
import 'package:flutter_template/themes/app_colors.dart';

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
        backgroundColor: AppColors.themColor,
        title: const Text('Followers'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            renderCtaBtn(),
            renderListFollowers(),
          ],
        ),
      ),
    );
  }

  Widget renderCtaBtn() {
    return Center(
      child: CommonButton(
        onPress: () {
          _followerBloc.add(FollowerFetch());
        },
        text: "Get followers",
      ),
    );
  }

  Widget renderListFollowers() {
    return Expanded(
      child: BlocProvider(
        create: (_) => _followerBloc,
        child: BlocBuilder<FollowerBloc, FollowerState>(
          builder: (context, state) {
            switch (state.status) {
              case FollowerStatus.failure:
                return Center(child: Text(state.errMessage));
              case FollowerStatus.success:
                if (state.followers?.isEmpty == true) {
                  return const Center(child: Text('no followers'));
                }
                var followers = state.followers!;
                return RefreshIndicator(
                  onRefresh: () async {
                    _followerBloc.add(FollowerReload());
                  },
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= followers.length
                          ? const BottomLoader()
                          : FollowerItem(follower: followers[index]);
                    },
                    itemCount: state.hasReachedMax ? followers.length : followers.length + 1,
                    controller: _scrollController,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8);
                    },
                  ),
                );
              case FollowerStatus.initial:
                return const SizedBox.shrink();
              case FollowerStatus.loading:
                return const BottomLoader();
            }
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
