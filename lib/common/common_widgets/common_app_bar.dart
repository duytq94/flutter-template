import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isShowLeading;

  const CommonAppBar({
    super.key,
    required this.title,
    this.isShowLeading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: isShowLeading == true
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.maybePop(context);
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
