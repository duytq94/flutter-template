import 'package:flutter/material.dart';

import '../../themes/app_colors.dart';

class CommonButton extends StatelessWidget {
  final Function() onPress;
  final String text;

  const CommonButton({super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(backgroundColor: AppColors.mainColor),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
