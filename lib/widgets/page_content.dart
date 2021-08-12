import 'package:flutter/material.dart';

import 'package:user_support_mobile/models/message_conversation.dart';
import 'package:user_support_mobile/widgets/message_card.dart';

class PageContentWidget extends StatelessWidget {
  final MessageConversation data;

  const PageContentWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String firstLetter =
        data.user!.displayName.substring(0, 1).toUpperCase();
    return MessageCardWidget(
        thumbnail: CircleAvatar(
          backgroundColor: const Color(0xFF1D5288),
          child: Text(
            firstLetter,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        userName: data.user!.displayName,
        subject: data.subject,
        messageContent: data.displayName,
        publishDate: '20 may',
        readDuration: '2 min ago');
  }
}

class AltenativePageContentWidget extends StatelessWidget {
  final MessageConversation data;

  const AltenativePageContentWidget({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MessageCardWidget(
        thumbnail: const CircleAvatar(
          backgroundColor: Color(0xFF1D5288),
          child: Text(
            'S',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subject: data.subject,
        messageContent: data.displayName,
        publishDate: '20 may',
        readDuration: '2 min ago');
  }
}
