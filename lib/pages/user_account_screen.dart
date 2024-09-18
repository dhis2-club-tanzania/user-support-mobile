import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/models/message_conversation.dart';
import 'package:user_support_mobile/providers/provider.dart';
import 'package:user_support_mobile/widgets/message_card.dart';
import 'package:user_support_mobile/widgets/show_loading.dart';
import 'package:html/parser.dart' as html_parser;

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({Key? key}) : super(key: key);

  @override
  State<UserAccountScreen> createState() => _UserAccountScreenState();
}

class _UserAccountScreenState extends State<UserAccountScreen> {
  List<MessageConversation> _searchResult = [];

  @override
  Widget build(BuildContext context) {
    context.read<MessageModel>().fetchUserApproval;

    String _parseHtmlString(String htmlString) {
      final document = html_parser.parse(htmlString);
      final String parsedString = html_parser.parse(document.body?.text ?? '').documentElement?.text ?? '';
      return parsedString;
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('User Account'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await context.read<MessageModel>().fetchUserApproval;
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<MessageModel>().fetchUserApproval;
        },
        child: SafeArea(
          child: Center(
            child: Consumer<MessageModel>(
              builder: (context, value, child) {
                if (value.map.isEmpty && value.userApproval.isEmpty) {
                  return LoadingListPage();
                } else {
                  return SizedBox(
                    width: size.width * 0.99,
                    child: Scrollbar(
                      thumbVisibility: false,
                      thickness: 10.0, // Thickness of the scrollbar
                      radius: const Radius.circular(8.0), // Rounded edges for the scrollbar thumb
                      child: ListView(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: _searchResult.isEmpty
                                ? value.userApproval.length
                                : _searchResult.length,
                            itemBuilder: (context, index) {
                              final messageData = value.userApproval[index];

                              return Row(
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: ClipRect(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * 0.99,
                                          ),
                                          child: MessageBox(
                                            userApproval: messageData,
                                            isUserApproval: true,
                                            lastMessage: calculateDateDifference(DateTime.fromMillisecondsSinceEpoch(int.parse(messageData.id!.split("_")[0].replaceAll("UA", "")))),
                                            subject: _parseHtmlString(messageData.action ?? 'No Subject'),
                                            displayName: _parseHtmlString(messageData.message?.subject?.split("-").last ?? 'No Display'),
                                            messageId: messageData.id ?? 'No ID',
                                            read: false,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
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