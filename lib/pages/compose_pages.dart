import 'dart:io';
// import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/widgets/search.dart';

import '../providers/provider.dart';
import '../widgets/attachment_button.dart';

import '../models/message_conversation.dart';
import '../models/user_messages.dart';
import '../widgets/search.dart';

class AbsorpPainterPage2 extends StatefulWidget {
  const AbsorpPainterPage2({Key? key}) : super(key: key);

  @override
  AbsorpPainterPage2State createState() => AbsorpPainterPage2State();
}

class AbsorpPainterPage2State extends State<AbsorpPainterPage2> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
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
    final fileName = file != null ? basename(file!.path) : "";
    final fetchedData = Provider.of<MessageModel>(context);
    final datas = fetchedData.fetchedThread;
    final messageId = datas.id;
    bool isLoading = fetchedData.isLoading;

    // final Size size = MediaQuery.of(context).size;
    final Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          child: ComposePageTesting(),
        ),
        if (isLoading)
          SizedBox(
            width: size.width,
            height: size.height,
            child: AbsorbPointer(
              absorbing: isLoading,
              child: Container(
                color: Colors.white.withOpacity(0.2),
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 10,
                )),
              ),
            ),
          )
        else
          Container(),
      ],
    );
  }

  Widget _messageThread(MessageConversation messagesData) {
    return ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: messagesData.messageCount.isNotEmpty
            ? messagesData.messages!.length
            : 0,
        itemBuilder: (context, index) {
          String messageFrom;
          if (messagesData.messages![index].sender != null) {
            messageFrom = messagesData.messages![index].sender!.displayName;
          } else {
            messageFrom = "System";
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Card(
              child: ListTile(
                // trailing: Text(
                //     messagesData.messages![index].lastUpdated.substring(0, 10)),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Message from $messageFrom'),
                      Text(messagesData.messages![index].lastUpdated
                          .substring(0, 10)),
                    ],
                  ),
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

class ComposePageTesting extends StatefulWidget {
  static const routeName = '/compose-page';

  const ComposePageTesting({Key? key}) : super(key: key);

  @override
  _ComposePageTestingState createState() => _ComposePageTestingState();
}

class _ComposePageTestingState extends State<ComposePageTesting> {
  bool isPrivate = false;
  bool isFeedback = false;
  File? file;
  String? selectedUser;
  bool isVisible = true;
  bool isButtonEnabled = false;
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingController1 = TextEditingController();
  final TextEditingController _textEditingController2 = TextEditingController();

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

    final Size size = MediaQuery.of(context).size;
    List<String> selectedUser =
        isFeedback ? ['Feedback Recipient Group'] : ['me'];
    final bool isEnableAll = !isButtonEnabled || !(isPrivate || isFeedback);

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
          title: const Text(
            'Compose Message',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              height: size.height,
              width: size.width * 0.9,
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "To",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                      buildParticipantsList(selectedUser),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        width: size.width * 0.6,
                        child: Container(
                          child: TextFormField(
                            controller: _textEditingController2,
                            onChanged: (query) {
                              fetchedData.queryUserGroups(query).whenComplete(
                                    () => fetchedData
                                        .queryOrgarnizationUnits(query)
                                        .whenComplete(
                                          () => fetchedData.queryUser(query),
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

                              setState(() {});
                            } else {
                              fetchedData.addParticipant();
                            }
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              shape: CircleBorder(),
                              value: isPrivate,
                              onChanged: (value) {
                                setState(() {
                                  isPrivate = value!;
                                  isFeedback = false;
                                });
                              }),
                          Text(
                            'Private Message',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              shape: CircleBorder(),
                              value: isFeedback,
                              onChanged: (value) {
                                setState(() {
                                  isFeedback = value!;
                                  isPrivate = false;
                                });
                              }),
                          Text(
                            'Feedback Message',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(left: size.width * 0.05),
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(color: Colors.black26)),
                    child: TextFormField(
                      onFieldSubmitted: null,
                      controller: _textEditingController1,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Subject",
                      ),
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
                        hintText: "Compose Text",
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
                          absorbing: isEnableAll,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: isEnableAll
                                  ? MaterialStateProperty.all(Color(0xFFE0E0E0))
                                  : MaterialStateProperty.all(
                                      Color(0xFF235EA0)),
                            ),
                            onPressed: () {
                              if (_textEditingController.text.trim() != "") {
                                print("print private bool $isPrivate");
                                print("print feedback bool $isFeedback");
                                if (isPrivate) {
                                  print("Inside Private body");
                                  fetchedData
                                      .addNewMessage(
                                          'attachment',
                                          _textEditingController.text,
                                          _textEditingController1.text)
                                      .then(
                                        (_) => fetchedData.fetchPrivateMessages,
                                      );
                                }
                                if (isFeedback) {
                                  fetchedData
                                      .addFeedbackMessage(
                                          _textEditingController1.text,
                                          _textEditingController.text)
                                      .then(
                                        (_) => fetchedData.fetchPrivateMessages,
                                      );
                                  print("Iversion");
                                }

                                isButtonEnabled = false;
                              }
                              setState(() {
                                _textEditingController.text = '';
                                _textEditingController1.text = '';
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Reply',
                                style: TextStyle(
                                  color: !isEnableAll
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
                                _textEditingController1.text = '';

                                isButtonEnabled = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
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
                  const SizedBox(
                    height: 22,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildParticipantsList(List<String>? users) {
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
                        height: 30,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color(0xFFE0E0E0),
                        ),
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        child: Text(element, textAlign: TextAlign.center)))
                    .toList(),
              ),
            ),
          )
        : Container();
  }
}
