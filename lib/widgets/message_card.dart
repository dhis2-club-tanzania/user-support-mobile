import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../models/approve_model.dart';

class MessageBox extends StatelessWidget {
  MessageBox({
    required this.lastMessage,
    this.isDataApproval = false,
    this.dataApproval,
    this.isUserApproval = false,
    this.userApproval,
    required this.messageId,
    required this.read,
    required this.displayName,
    required this.subject,
    Key? key,
  }) : super(key: key);

  final String messageId;
  final bool read;
  final bool? isDataApproval;
  final ApproveModel? dataApproval;
  final bool? isUserApproval;
  final UserModel? userApproval;

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


        // Navigate based on approval type
        if (isDataApproval == true && dataApproval != null) {
          context.go('/home/request_details', extra: dataApproval);
        } else if (isUserApproval == true && userApproval != null) {
          context.go('/home/user_account_details', extra: userApproval);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: read ? Colors.white : Colors.blue[50],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(8, 20, 10, 1),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Icon(
              isDataApproval == true ? Icons.assignment : Icons.person,
              color: Colors.blueAccent,
              size: 30,
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/arrow.svg',
                        semanticsLabel: 'Acme Logo',
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          displayName,
                          style: TextStyle(
                            fontWeight: read ? FontWeight.w400 : FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 17.0,
                          ),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          subject,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(
                            fontWeight: read ? FontWeight.w400 : FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 15.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    lastMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
