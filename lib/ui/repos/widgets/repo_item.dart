import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/ui/repos/models/repo.dart';

class RepoItem extends StatelessWidget {
  const RepoItem({super.key, required this.repo});

  final Repo repo;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${repo.name}', style: const TextStyle(color: Colors.black)),
            Text('Description: ${repo.description}', style: const TextStyle(color: Colors.black54)),
            Text('Url: ${repo.url}', style: const TextStyle(color: Colors.black54)),
            Text('Language: ${repo.language}', style: const TextStyle(color: Colors.black54)),
            Text("Star: ${repo.star.toString()}", style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
