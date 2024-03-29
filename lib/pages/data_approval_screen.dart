import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_conversation.dart';
import '../providers/provider.dart';
import '../widgets/message_card.dart';
import '../widgets/show_loading.dart';

class DataApprovalScreen extends StatefulWidget {
  const DataApprovalScreen({Key? key}) : super(key: key);

  static const routeName = '/approve-page';
  @override
  _DataApprovalScreenState createState() => _DataApprovalScreenState();
}

class _DataApprovalScreenState extends State<DataApprovalScreen> {
  List<MessageConversation> _searchResult = [];
  @override
  Widget build(BuildContext context) {
    context.read<MessageModel>().fetchDataApproval;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Form requests'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<MessageModel>().fetchDataApproval;
        },
        child: SafeArea(
          child: Center(
            child: Consumer<MessageModel>(
              builder: (context, value, child) {
                if (value.map.isEmpty && value.dataApproval.isEmpty) {
                  return LoadingListPage();
                } else {
                  return SizedBox(
                    width: size.width * 0.99,
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // searchBarWidget(context, value),
                        // const Padding(
                        //   padding: EdgeInsets.only(left: 8.0, top: 8.0),
                        //   child: Text(
                        //     'Pending Requests',
                        //     style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        // ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: _searchResult.isEmpty
                              ? value.dataApproval.length
                              : _searchResult.length,
                          itemBuilder: (context, index) {
                            final messageData = value.dataApproval[index];
                            return MessageBox(
                                dataApproval: messageData,
                                isDataApproval: true,
                                lastMessage: DateTime.now().toString(),
                                subject: messageData.message!.message!,
                                displayName: messageData.message!.subject!
                                    .split("-")
                                    .last,
                                read: false,
                                messageId: messageData.id!);
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.pushNamed(context, ComposePainter.routeName),
      //   child: const Icon(Icons.add),
      // ),
      // drawer: const NavigationDrawer(),
    );
  }

  Container searchBarWidget(BuildContext context, MessageModel value) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          border: Border.all(color: Colors.black26)),
      child: Row(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: IconButton(
              splashColor: Colors.grey,
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
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

                if (query.trim().isNotEmpty) {
                  setState(() {
                    _searchResult = value.ticketMessage.where((element) {
                      final messageTitle = element.displayName.toLowerCase();
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
