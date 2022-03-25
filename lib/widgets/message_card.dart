import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/pages/data_approval_detail.dart';
import 'package:clock/clock.dart';

import 'package:user_support_mobile/pages/message_conversation_page.dart';
import 'package:user_support_mobile/pages/testing_page.dart';
import 'package:user_support_mobile/providers/provider.dart';

class MessageBox extends StatelessWidget {
  MessageBox(
      {required this.lastMessage,
      this.isDataApproval,
      required this.messageId,
      required this.read,
      required this.displayName,
      required this.subject,
      Key? key})
      : super(key: key);
  final String messageId;
  final bool read;
  bool? isDataApproval = false;
  final String subject;
  final String displayName;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    // context.read<MessageModel>().fetchMessageThreads(messageId);
    final fetchedData = Provider.of<MessageModel>(context);
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        fetchedData.initialValue();
        fetchedData.fetchMessageThreadsById(messageId);

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return isDataApproval == false
                ? const AbsorpPainterPage()
                : DataApprovalDetailPage();
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 10, 1),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              child: CircleAvatar(
                child: Text(
                  firstLetter(displayName),
                  style: const TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/images/arrow.svg',
                                semanticsLabel: 'Acme Logo'),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              displayName,
                              style: TextStyle(
                                fontWeight:
                                    read ? FontWeight.w400 : FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat("yyyy-MM-dd")
                              .parse(lastMessage)
                              .toString()
                              .substring(0, 10),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              fontSize: 13.5),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                subject,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight:
                                      read ? FontWeight.w400 : FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 15.5,
                                ),
                              ),
                            ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.6,
                            //   child: const Text(
                            //     'There is no text to be displayed',
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w400,
                            //         color: Colors.black54,
                            //         fontSize: 15.5),
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String firstLetter(String s) {
    return s.substring(0, 1);
  }
}
