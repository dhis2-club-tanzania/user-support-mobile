import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/pages/compose_page.dart';

import 'package:user_support_mobile/providers/provider.dart';
import 'package:user_support_mobile/widgets/drawer_nav.dart';
import 'package:user_support_mobile/widgets/message_card.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MessageModel>().fetchPrivateMessages;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<MessageModel>().initialValue();

          await context.read<MessageModel>().fetchPrivateMessages;
        },
        child: Center(
          child: Consumer<MessageModel>(
            builder: (context, value, child) {
              if (value.map.isEmpty && !value.error) {
                return const CircularProgressIndicator();
              } else {
                print(value.privateMessages.length);

                return value.error
                    ? Text(
                        'Oops Somthing is wrong ${value.errorMessage}',
                        textAlign: TextAlign.center,
                      )
                    : ListView.builder(
                        itemCount: value.privateMessages.length,
                        itemBuilder: (context, index) {
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
                              lastMessage:
                                  value.privateMessages[index].displayName,
                              subject: value.privateMessages[index].subject,
                              displayName:
                                  value.privateMessages[index].messageType,
                              read: value.privateMessages[index].read,
                            ),
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
      // drawer: const NavigationDrawer(),
    );
  }
}
