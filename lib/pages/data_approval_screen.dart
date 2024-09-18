import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_conversation.dart';
import '../providers/provider.dart';
import '../widgets/message_card.dart';
import '../widgets/show_loading.dart';

class DataApprovalScreen extends StatefulWidget {
  const DataApprovalScreen({Key? key}) : super(key: key);

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
                      children: <Widget>[
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
                                lastMessage: calculateDateDifference(DateTime.fromMillisecondsSinceEpoch(int.parse(messageData.id!.split("_")[0].replaceAll("DS", "")))),
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
    );
  }
}

String calculateDateDifference(DateTime created) {
  DateTime now = DateTime.now();
  Duration diff = now.difference(created);

  if (diff.inDays > 365) {
    int years = (diff.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  } else if (diff.inDays > 30) {
    int months = (diff.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else if (diff.inDays > 7) {
    int weeks = (diff.inDays / 7).floor();
    return '$weeks week${weeks > 1 ? 's' : ''} ago';
  } else if (diff.inDays > 0) {
    return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
  } else if (diff.inHours > 0) {
    return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'a Few Seconds Ago';
  }
}