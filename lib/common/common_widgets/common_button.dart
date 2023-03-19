import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class CommonButton extends StatelessWidget {
  final Function() onPress;
  final String text;

  const CommonButton({
    super.key,
    required this.onPress,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPress,
      color: AppColors.mainColor,
      borderRadius: BorderRadius.circular(16),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
