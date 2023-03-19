import 'package:flutter/material.dart';
import 'package:flutter_template/common/common_widgets/common_widget.dart';
import 'package:flutter_template/ui/followers/pages/followers_page.dart';
import 'package:flutter_template/ui/repos/pages/repos_page.dart';
import 'package:flutter_template/ui/user_details/pages/user_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Home",
        isShowLeading: false,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            const SizedBox(height: 20),
            _renderNavBtn(name: "Go user details page", page: const UserDetailsPage()),
            const SizedBox(height: 20),
            _renderNavBtn(name: "Go followers page", page: const FollowerPage()),
            const SizedBox(height: 20),
            _renderNavBtn(name: "Go repository page", page: const ReposPage()),
          ],
        ),
      ),
    );
  }

  Widget _renderNavBtn({required String name, required StatefulWidget page}) {
    return Center(
      child: CommonButton(
        onPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        text: name,
      ),
    );
  }
}
