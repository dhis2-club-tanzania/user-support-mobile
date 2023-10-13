import 'package:flutter/material.dart';

import '../../helpers/colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final String textColor;
  final String? fontWeight;
  final double? fontSize;
  const AppText({
    Key? key,
    required this.text,
    required this.textColor,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: getTextColor(textColor),
          fontSize: fontSize ?? 12,
          fontWeight:
              fontWeight == 'bold' ? FontWeight.w800 : FontWeight.normal,
          decoration: TextDecoration.none),
    );
  }

  getTextColor(String textColor) {
    switch (textColor) {
      case 'white':
        return Colors.white;
      case 'black':
        return Colors.black;
      case 'muted':
        return AppColors.textMuted;

      default:
        return Colors.black;
    }
  }
}
