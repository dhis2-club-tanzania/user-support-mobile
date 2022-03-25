import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/pages/inbox_page.dart';
import '/providers/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MessageModel>().fetchTicketMessages;
    context.read<MessageModel>().fetchSystemMessage;

    return const Scaffold(
      body: InboxPage(),
    );
  }
}
