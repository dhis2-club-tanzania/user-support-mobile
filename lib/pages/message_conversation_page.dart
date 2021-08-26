import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:user_support_mobile/widgets/attachment_button.dart';
import 'package:path/path.dart';

import '../models/message_conversation.dart';
import '../models/user_messages.dart';
import '../providers/provider.dart';
import '../widgets/search.dart';

class MessageConversationPage extends StatefulWidget {
  const MessageConversationPage({Key? key, required this.messageId})
      : super(key: key);

  final String messageId;

  @override
  _MessageConversationPageState createState() =>
      _MessageConversationPageState();
}

class _MessageConversationPageState extends State<MessageConversationPage> {
  File? file;
  String? selectedUser;
  bool isVisible = true;
  bool isButtonEnabled = false;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();

  @override
  bool isEmpty() {
    setState(() {
      if (_textEditingController.text.trim() != "") {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
    return isButtonEnabled;
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : '';

    final replyData = Provider.of<MessageModel>(context);
    // context.read<MessageModel>().fetchReply(widget.messageId);
    // var value = context.
    final datas = replyData.findById(widget.messageId);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          datas.displayName,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            height: size.height,
            width: size.width * 0.9,
            child: Column(
              children: [
                buildParticipantsList(datas.userMessages),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        width: size.width * 0.6,
                        child: Container(
                          child: TextFormField(
                            controller: _textEditingController1,
                            onTap: () async {
                              if (_textEditingController1.text.trim().isEmpty) {
                                final user = await showSearch(
                                    context: context,
                                    delegate: SearchUser(allUsers: [
                                      'Tom Wakiki',
                                      'Wile',
                                      'Goodluck'
                                    ], usersSuggestion: [
                                      'Tom Wakiki',
                                      'Duke',
                                      'John Traore',
                                      'wile'
                                    ]));

                                setState(() {
                                  selectedUser = user;
                                  _textEditingController1.text = selectedUser!;
                                });
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Add New Participant",
                              hintStyle: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: size.width * 0.2,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (_textEditingController1.text.trim().isEmpty) {
                              final user = await showSearch(
                                  context: context,
                                  delegate: SearchUser(allUsers: [
                                    'Tom Wakiki',
                                    'Wile',
                                    'Goodluck'
                                  ], usersSuggestion: [
                                    'Tom Wakiki',
                                    'Duke',
                                    'John Traore',
                                    'wile'
                                  ]));

                              setState(() {
                                selectedUser = user;
                                _textEditingController1.text = selectedUser!;
                              });
                            } else {
                              //add new user to the exact convo
                            }
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  width: size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      border: Border.all(color: Colors.black26)),
                  child: TextFormField(
                    onFieldSubmitted: null,
                    controller: _textEditingController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    onChanged: (val) {
                      isEmpty();
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Compose reply",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                if (file != null)
                  Text(
                    fileName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  )
                else
                  Container(),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: Row(
                    children: [
                      AbsorbPointer(
                        absorbing: !isButtonEnabled,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: !isButtonEnabled
                                ? MaterialStateProperty.all(Color(0xFFE0E0E0))
                                : MaterialStateProperty.all(Color(0xFF235EA0)),
                          ),
                          onPressed: () {
                            if (_textEditingController.text.trim() != "") {
                              replyData.sendMessages(widget.messageId,
                                  _textEditingController.text);
                            }
                            setState(() {
                              _textEditingController.text = '';
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Reply',
                              style: TextStyle(
                                color: isButtonEnabled
                                    ? Colors.white
                                    : Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      AbsorbPointer(
                        absorbing: !isButtonEnabled,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor: !isButtonEnabled
                                ? MaterialStateProperty.all(Color(0xFFE0E0E0))
                                : MaterialStateProperty.all(Colors.white),
                          ),
                          onPressed: () async {
                            setState(() {
                              _textEditingController.text = '';
                              isButtonEnabled = false;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Discard',
                              style: TextStyle(
                                color: isButtonEnabled
                                    ? Colors.black
                                    : Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ButtonWidget(
                            isButtonEnabled: isButtonEnabled,
                            icon: Icons.attachment_rounded,
                            text: '',
                            onClicked: selectFile),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 22),
                _messageThread(datas),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageThread(MessageConversation? messagesData) {
    return Container(
      child: messagesData != null
          ? Expanded(
              flex: 6,
              child: ListView.builder(
                  itemCount: messagesData.messages!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Card(
                        child: ListTile(
                          trailing: Text(messagesData
                              .messages![index].lastUpdated
                              .substring(0, 10)),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                                'Message from ${messagesData.messages![index].sender.displayName}'),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              messagesData.messages![index].text,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  }),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

Widget buildParticipantsList(List<UserMessages>? users) {
  return Container(
    height: 50,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: -1,
        direction: Axis.vertical,
        children: users!
            .map((element) => Container(
                // margin: EdgeInsets.symmetric(horizontal: 5),
                width: 130,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xFFE0E0E0),
                ),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Text(element.users!.displayName,
                    textAlign: TextAlign.center)))
            .toList(),
      ),
    ),
  );
}