import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageDescription extends StatelessWidget {
  const MessageDescription({
    Key? key,
    this.userName,
    required this.subject,
    required this.messageContent,
    required this.publishDate,
    required this.readDuration,
  }) : super(key: key);

  final String? userName;
  final String subject;
  final String messageContent;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/images/arrow.svg',
                semanticsLabel: 'Acme Logo'),
            SizedBox(
              width: 4.0,
            ),
            Text(
              userName ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: size.width * 0.39,
            ),
            Text(
              '12:20 am',
              style: TextStyle(
                fontSize: 10.0,
              ),
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 3.0)),
        Text(
          subject,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color(0xFF292929),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 2.0,
          ),
          child: Text(
            messageContent,
            style: const TextStyle(
              fontSize: 14.0,
              color: Color(0xFF5D5C5D),
            ),
            maxLines: 1,
          ),
        ),
        // Container(
        //     width: 100,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       border: Border.all(
        //         color: Colors.blueAccent,
        //       ),
        //     ),
        //     child: Row(
        //       children: [
        //         Icon(Icons.attachment),
        //         Text('Attachment'),
        //       ],
        //     ))
      ],
    );
  }
}
