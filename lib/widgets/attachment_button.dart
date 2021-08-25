import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final bool isButtonEnabled;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.isButtonEnabled,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      child: AbsorbPointer(
        absorbing: !isButtonEnabled,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            primary: Color.fromRGBO(29, 194, 95, 1),
            minimumSize: Size.fromHeight(40),
          ),
          child: buildContent(),
          onPressed: onClicked,
        ),
      ),
    );
  }

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.black54,
          ),
        ],
      );
}
