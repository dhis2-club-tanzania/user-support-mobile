import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:user_support_mobile/providers/provider.dart';
import 'package:user_support_mobile/widgets/drawer_nav.dart';
import 'package:user_support_mobile/widgets/message_box.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MessageModel>().fetchAllMessageConversations;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<MessageModel>().fetchAllMessageConversations;
        },
        child: Center(
          child: Consumer<MessageModel>(
            builder: (context, value, child) {
              if (value.map.isEmpty && !value.error) {
                return const CircularProgressIndicator();
              } else {
                return value.error
                    ? Text(
                        'Oops Somthing is wrong ${value.errorMessage}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: value.allMessageConversation.length,
                        itemBuilder: (context, index) {
                          final allConversation =
                              value.allMessageConversation[index];
                          int count = 0;
                          if (allConversation.user != null) {
                            if (allConversation.messageType
                                .contains('TICKET')) {
                              count++;
                              return Slidable(
                                actionPane: const SlidableDrawerActionPane(),
                                actions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Approve',
                                    color: Colors.blue,
                                    icon: Icons.approval,
                                    onTap: () {},
                                  ),
                                ],
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Reject',
                                    color: Colors.black45,
                                    icon: Icons.block,
                                    onTap: () {},
                                  ),
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () {},
                                  ),
                                ],
                                child: MessageBox(
                                  subject: value
                                      .allMessageConversation[index].subject,
                                  displayName: value
                                      .allMessageConversation[index]
                                      .user!
                                      .displayName,
                                ),
                              );
                            } else {
                              return Slidable(
                                actionPane: const SlidableDrawerActionPane(),
                                actions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Approve',
                                    color: Colors.blue,
                                    icon: Icons.approval,
                                    onTap: () {},
                                  ),
                                ],
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Reject',
                                    color: Colors.black45,
                                    icon: Icons.block,
                                    onTap: () {},
                                  ),
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () {},
                                  ),
                                ],
                                child: MessageBox(
                                  subject: value
                                      .allMessageConversation[index].subject,
                                  displayName: 'System Notification',
                                ),
                              );
                            }
                          } else {
                            return Container();
                          }
                        },
                      );
              }
            },
          ),
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
