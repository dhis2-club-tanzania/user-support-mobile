import 'package:flutter/material.dart';
import 'package:user_support_mobile/widgets/message_description.dart';

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget({
    Key? key,
    required this.thumbnail,
    this.userName = 'System Notification',
    required this.subject,
    required this.messageContent,
    required this.publishDate,
    required this.readDuration,
  }) : super(key: key);

  final Widget thumbnail;
  final String? userName;
  final String subject;
  final String messageContent;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.90,
      child: SizedBox(
        height: size.width * 0.22,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: AspectRatio(
                aspectRatio: 0.45,
                child: thumbnail,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 2.0, 0.0),
                child: MessageDescription(
                  userName: userName,
                  subject: subject,
                  messageContent: messageContent,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
