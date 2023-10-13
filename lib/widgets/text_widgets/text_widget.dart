import 'package:flutter/material.dart';

class TextWidgetBold extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double top;
  final double bottom;
  final double left;
  final double right;

  const TextWidgetBold({
    Key? key,
    required this.text,
    this.size = 20,
    this.color = Colors.black,
    this.top = 0,
    this.bottom = 0,
    this.right = 0,
    this.left = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}

class TextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final double top;
  final double bottom;
  final double left;
  final double right;

  const TextWidget(
      {Key? key,
      required this.text,
      this.size = 20,
      this.color = Colors.black,
      this.top = 0,
      this.bottom = 0,
      this.right = 0,
      this.left = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: size),
        ));
  }
}
