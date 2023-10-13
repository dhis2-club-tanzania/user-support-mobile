import 'package:flutter/material.dart';

class CircularProgressLoader extends StatelessWidget {
  const CircularProgressLoader(this.loadingText, this.color, {Key? key})
      : super(key: key);
  final String loadingText;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 15.0,
          width: 15.0,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(
                color != null ? color as Color : Colors.blue),
            strokeWidth: 2,
          ),
        ),
        const SizedBox(
          height: 15.0,
          width: 15.0,
        ),
        Text(
          loadingText,
          style: TextStyle(
            color: color != null ? color as Color : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class DisabledProgressLoader extends StatelessWidget {
  const DisabledProgressLoader(
      this.loadingText, this.color, this.backgroundColor,
      {Key? key})
      : super(key: key);
  final String loadingText;
  final Color color;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 15.0,
            width: 15.0,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(color),
              strokeWidth: 2,
            ),
          ),
          const SizedBox(
            height: 15.0,
            width: 15.0,
          ),
          Text(
            loadingText,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
