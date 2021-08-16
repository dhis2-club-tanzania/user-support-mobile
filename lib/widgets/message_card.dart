import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageBox extends StatelessWidget {
  MessageBox({required this.displayName, required this.subject, Key? key})
      : super(key: key);
  final String subject;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 10, 1),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            child: CircleAvatar(
              child: Text(
                firstLetter(displayName),
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/arrow.svg',
                              semanticsLabel: 'Acme Logo'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            displayName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 17.0),
                          ),
                        ],
                      ),
                      Text(
                        '2 min ago',
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
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                                fontSize: 15.5,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: const Text(
                              'There is no text to review',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black54,
                                  fontSize: 15.5),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
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
    );
  }

  String firstLetter(String s) {
    return s.substring(0, 1);
  }
}
