import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../models/message_conversation.dart';
import '../models/user_messages.dart';
import '../providers/provider.dart';
import '../widgets/attachment_button.dart';
import '../widgets/search.dart';

class MessageConversationPage extends StatefulWidget {
  const MessageConversationPage({Key? key}) : super(key: key);

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

    final fetchedData = Provider.of<MessageModel>(context);
    final datas = fetchedData.fetchedThread;

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
      body: datas.messageType.trim().isNotEmpty
          ? SafeArea(
              child: Center(
                child: Container(
                  height: size.height,
                  width: size.width * 0.9,
                  child: ListView(
                    children: [
                      buildParticipantsList(datas.userMessages),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            width: size.width * 0.6,
                            child: Container(
                              child: TextFormField(
                                controller: _textEditingController1,
                                onChanged: (query) {
                                  fetchedData
                                      .queryUserGroups(query)
                                      .whenComplete(
                                        () => fetchedData
                                            .queryOrgarnizationUnits(query)
                                            .whenComplete(
                                              () =>
                                                  fetchedData.queryUser(query),
                                            ),
                                      );
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
                                if (_textEditingController1.text
                                    .trim()
                                    .isEmpty) {
                                  final user = await showSearch(
                                    context: context,
                                    delegate: SearchUser(
                                      allUsers: [
                                        'Tom Wakiki',
                                        'Wile',
                                        'Goodluck'
                                      ],
                                      usersSuggestion: [
                                        'Tom Wakiki',
                                        'Duke',
                                        'John Traore',
                                        'wile'
                                      ],
                                    ),
                                  );

                                  setState(() {
                                    selectedUser = user;
                                    _textEditingController1.text =
                                        selectedUser!;
                                  });
                                } else {
                                  fetchedData.addParticipant();
                                }
                              },
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // SizedBox(height: 22),
                      _messageThread(datas),
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
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
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
                        child: Row(
                          children: [
                            AbsorbPointer(
                              absorbing: !isButtonEnabled,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: !isButtonEnabled
                                      ? MaterialStateProperty.all(
                                          Color(0xFFE0E0E0))
                                      : MaterialStateProperty.all(
                                          Color(0xFF235EA0)),
                                ),
                                onPressed: () {
                                  if (_textEditingController.text.trim() !=
                                      "") {
                                    fetchedData
                                        .sendMessages(
                                            fetchedData.fetchedThread.id,
                                            _textEditingController.text)
                                        .whenComplete(
                                          () => fetchedData
                                              .fetchMessageThreadsById(
                                            fetchedData.fetchedThread.id,
                                          ),
                                        );
                                    isButtonEnabled = false;
                                  }
                                  setState(() {
                                    _textEditingController.text = '';
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
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
                                      ? MaterialStateProperty.all(
                                          const Color(0xFFE0E0E0))
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
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _messageThread(MessageConversation messagesData) {
    print('inside message thread');
    print("${messagesData.messages!.length}");
    return ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: messagesData.messageCount.isNotEmpty
            ? messagesData.messages!.length
            : 0,
        itemBuilder: (context, index) {
          var messageFrom = messagesData.messages![index].sender != null
              ? messagesData.messages![index].sender!.displayName
              : "System";
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Card(
              child: ListTile(
                trailing: Text(
                    messagesData.messages![index].lastUpdated.substring(0, 10)),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('Message from $messageFrom'),
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
        });
  }
}

Widget buildParticipantsList(List<UserMessages>? users) {
  return users != null
      ? Container(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: -1,
              direction: Axis.vertical,
              children: users
                  .map((element) => Container(
                      width: 130,
                      height: 30,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0xFFE0E0E0),
                      ),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      child: Text(element.users!.displayName,
                          textAlign: TextAlign.center)))
                  .toList(),
            ),
          ),
        )
      : Container();
}
