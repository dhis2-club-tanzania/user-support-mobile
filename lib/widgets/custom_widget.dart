


import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final String line1;
  final String line2;
  final String line3;
  final String line4;
  final String button1Text;
  final String button2Text;

  CustomWidget({
    required this.line1,
    required this.line2,
    required this.line3,
    required this.line4,
    required this.button1Text,
    required this.button2Text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Optional, adds a shadow effect

      margin: EdgeInsets.all(16), // Optional, adds some spacing around the card
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: text(line1)),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(child: text(line2)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement the action for the first button
                  },
                  child: Text(button1Text),
                ),
                // SizedBox(
                //   width: 15,
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Implement the action for the second button
                //   },
                //   child: Text(button2Text),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding text(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        softWrap: true,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
      ),
    );
  }
}
