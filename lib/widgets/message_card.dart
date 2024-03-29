import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../pages/data_approval_detail.dart';

import '../pages/testing_page.dart';
import '../providers/provider.dart';

import '../models/approve_model.dart';

class MessageBox extends StatelessWidget {
  MessageBox(
      {required this.lastMessage,
      this.isDataApproval = false,
      this.dataApproval,
      required this.messageId,
      required this.read,
      required this.displayName,
      required this.subject,
      Key? key})
      : super(key: key);
  final String messageId;
  final bool read;
  bool? isDataApproval;
  ApproveModel? dataApproval;
  final String subject;
  final String displayName;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
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
                : DataApprovalDetailPage(
                    dataApproval: dataApproval,
                  );
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 10, 1),
        child: Row(
          children: [
            if (!isDataApproval!)
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
                      subject,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: read ? FontWeight.w400 : FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 15.5,
                      ),
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
