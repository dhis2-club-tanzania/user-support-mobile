import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/widgets/show_loading.dart';

import '../models/message_conversation.dart';
import '../pages/compose_page.dart';
import '../providers/provider.dart';
import '../widgets/drawer_nav.dart';
import '../widgets/message_card.dart';

class InboxPage extends StatefulWidget {
  static const routeName = '/inbox-page';
  const InboxPage({Key? key}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  List<MessageConversation> _searchResult = [];
  @override
  Widget build(BuildContext context) {
    // context.read<MessageModel>().fetchPrivateMessages;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: const Text('Inbox'),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
          // context.read<MessageModel>().initialValue();
          await context.read<MessageModel>().fetchPrivateMessages;
        },
        child: SafeArea(
          child: Center(
            child: Consumer<MessageModel>(
              builder: (context, value, child) {
                if (value.map.isEmpty &&
                    !value.error &&
                    value.privateMessages.isEmpty) {
                  return LoadingListPage();
                } else {
                  print(value.privateMessages.length);

                  return value.error
                      ? Text(
                          'Oops Somthing is wrong ${value.errorMessage}',
                          textAlign: TextAlign.center,
                        )
                      : Container(
                          width: size.width * 0.95,
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              searchBarWidget(context, value),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Text(
                                  'Inbox',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: _searchResult.isEmpty
                                    ? value.privateMessages.length
                                    : _searchResult.length,
                                itemBuilder: (context, index) {
                                  var messageData = _searchResult.isEmpty
                                      ? value.privateMessages[index]
                                      : _searchResult[index];
                                  return Slidable(
                                    actionPane:
                                        const SlidableDrawerActionPane(),
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
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                title: Text('Are you sure?'),
                                                content: Text(
                                                  'Do you want to delete?',
                                                ),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text('No'),
                                                  ),
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                              'deleted message'),
                                                          duration: Duration(
                                                              seconds: 2),
                                                          action:
                                                              SnackBarAction(
                                                            label: 'UNDO',
                                                            onPressed: () {},
                                                          ),
                                                        ),
                                                      );
                                                      value.deleteMessage(value
                                                          .privateMessages[
                                                              index]
                                                          .id);

                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: const Text('Yes'),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                    child: MessageBox(
                                        lastMessage: messageData.lastMessage,
                                        subject: messageData.subject,
                                        displayName:
                                            messageData.lastSender!.displayName,
                                        read: value.privateMessages[index].read,
                                        messageId: messageData.id),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                }
              },
            ),
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

  Container searchBarWidget(BuildContext context, MessageModel value) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          border: Border.all(color: Colors.black26)),
      child: Row(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              splashColor: Colors.grey,
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Search..."),
              onChanged: (query) {
                query = query.toLowerCase();

                if (query.trim() != null) {
                  setState(() {
                    _searchResult = value.privateMessages.where((element) {
                      var messageTitle = element.displayName.toLowerCase();
                      return messageTitle.contains(query);
                    }).toList();
                  });
                } else {
                  _searchResult = [];
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
