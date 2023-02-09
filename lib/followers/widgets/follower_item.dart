import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/followers/models/follower.dart';

class FollowerItem extends StatelessWidget {
  const FollowerItem({super.key, required this.follower});

  final Follower follower;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(follower.avatarUrl, width: 50, height: 50),
            ),
            const SizedBox(width: 10),
            Text(follower.name, style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
