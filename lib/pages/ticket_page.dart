import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '/pages/compose_page.dart';
import '/providers/provider.dart';
import '/widgets/drawer_nav.dart';
import '/widgets/message_card.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MessageModel>().fetchTicketMessages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // context.read<MessageModel>().initialValue();

          await context.read<MessageModel>().fetchTicketMessages;
        },
        child: Center(
          child: Consumer<MessageModel>(
            builder: (context, value, child) {
              if (value.map.isEmpty && !value.error) {
                return const CircularProgressIndicator();
              } else {
                print(value.ticketMessage.length);

                return value.error
                    ? Text(
                        'Oops Somthing is wrong ${value.errorMessage}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: value.ticketMessage.length,
                        itemBuilder: (context, index) {
                          var messageData = value.ticketMessage[index];
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
                                lastMessage: messageData.lastMessage,
                                subject: messageData.subject,
                                displayName: messageData.lastSender != null
                                    ? messageData.lastSender!.displayName
                                    : "Ticket",
                                read: value.ticketMessage[index].read,
                                messageId: messageData.id),
                          );
                        },
                      );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const ComposePage();
          },
        )),
        child: const Icon(Icons.add),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
