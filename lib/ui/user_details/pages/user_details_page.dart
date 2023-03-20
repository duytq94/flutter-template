import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/common_widgets/common_widget.dart';

import '../bloc/user_details_bloc.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final _userDetailsBloc = UserDetailsBloc();

  @override
  void initState() {
    super.initState();
    _userDetailsBloc.add(FetchUserDetails());
  }

  @override
  void dispose() {
    super.dispose();
    _userDetailsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'User details',
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: _renderUserDetailsInfo(),
      ),
    );
  }

  Widget _renderUserDetailsInfo() {
    return BlocBuilder<UserDetailsBloc, UserDetailsState>(
      bloc: _userDetailsBloc,
      builder: (context, state) {
        if (state is UserDetailsFail) {
          return Center(child: Text(state.errMessage ?? ""));
        }
        if (state is UserDetailsSuccess) {
          var userDetails = state.userDetails;
          return Center(
            child: Column(
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
            ),
          );
        }
        if (state is UserDetailsInitial) {
          return const SizedBox.shrink();
        }
        if (state is UserDetailsLoading) {
          return const BottomLoader();
        }
        return const Center(child: Text("Undefined state"));
      },
    );
  }
}
