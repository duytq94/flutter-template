import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/common_widgets/common_button.dart';
import 'package:flutter_template/followers/pages/followers_page.dart';
import 'package:flutter_template/followers/widgets/bottom_loader.dart';
import 'package:flutter_template/themes/app_colors.dart';
import 'package:flutter_template/user_details/bloc/user_details_bloc.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late UserDetailsBloc _userDetailsBloc;

  @override
  void initState() {
    super.initState();
    _userDetailsBloc = UserDetailsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themColor,
        title: const Text('User details'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            renderCtaBtn(),
            renderNavBtn(),
            renderUserDetailsInfo(),
          ],
        ),
      ),
    );
  }

  Widget renderCtaBtn() {
    return Center(
      child: CommonButton(
        onPress: () {
          _userDetailsBloc.add(UserDetailsFetch());
        },
        text: "Get user details",
      ),
    );
  }

  Widget renderNavBtn() {
    return Center(
      child: CommonButton(
        onPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowerPage()));
        },
        text: "Go followers page",
      ),
    );
  }

  Widget renderUserDetailsInfo() {
    return Expanded(
      child: BlocProvider(
        create: (_) => _userDetailsBloc,
        child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case UserDetailsStatus.failure:
                return Center(child: Text(state.errMessage ?? ""));
              case UserDetailsStatus.success:
                if (state.userDetails != null) {
                  var userDetails = state.userDetails!;
                  return Column(
                    children: [
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(userDetails.avatarUrl, width: 80, height: 80),
                      ),
                      const SizedBox(height: 8),
                      Text(userDetails.username),
                      const SizedBox(height: 8),
                      Text(userDetails.name),
                      const SizedBox(height: 8),
                      Text(userDetails.location),
                    ],
                  );
                }
                return const SizedBox.shrink();
              case UserDetailsStatus.initial:
                return const SizedBox.shrink();
              case UserDetailsStatus.loading:
                return const BottomLoader();
            }
          },
        ),
      ),
    );
  }
}
