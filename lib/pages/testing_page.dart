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

class AbsorpPainterPage extends StatefulWidget {
  const AbsorpPainterPage({Key? key}) : super(key: key);

  @override
  AbsorpPainterPageState createState() => AbsorpPainterPageState();
}

class AbsorpPainterPageState extends State<AbsorpPainterPage> {
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
          child: Scaffold(
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
              actions: datas.messageType.trim().isNotEmpty
                  ? [
                      IconButton(
                        icon: Icon(
                          Icons.mail,
                          color: Colors.black87,
                        ),
                        onPressed: () => fetchedData.messageUnread(messageId),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text(
                                  'Do you want to delete?',
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('No'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('deleted message'),
                                          duration: Duration(seconds: 2),
                                          action: SnackBarAction(
                                            label: 'UNDO',
                                            onPressed: () {},
                                          ),
                                        ),
                                      );
                                      fetchedData.deleteMessage(messageId);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text('Yes'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.done,
                          color: Colors.black87,
                        ),
                        onPressed: () {
                          fetchedData.messageRead(messageId);
                        },
                      ),
                      IconButton(
                        color: Colors.black87,
                        icon: Icon(
                          Icons.more_vert,
                        ),
                        onPressed: () {},
                      ),
                    ]
                  : [],
            ),
            body: datas.messageType.trim().isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      await context
                          .read<MessageModel>()
                          .fetchMessageThreadsById(messageId);
                    },
                    child: SafeArea(
                      child: Center(
                        child: Container(
                          height: size.height,
                          width: size.width * 0.9,
                          child: ListView(
                            children: [
                              Text(
                                datas.displayName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              buildParticipantsList(datas.userMessages),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    width: size.width * 0.6,
                                    child: Container(
                                      child: TextFormField(
                                        controller: _textEditingController1,
                                        onChanged: (query) {
                                          // fetchedData
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
                                          // fetchedData.addParticipant();
                                        }
                                      },
                                      child: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _messageThread(datas),
                              Container(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.05),
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
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
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
                                          if (_textEditingController.text
                                                  .trim() !=
                                              '') {
                                            // var delaytime = Future.delayed(
                                            //     Duration(milliseconds: 2000));
                                            // print(
                                            //     "this is a id ${fetchedData.fetchedThread.id}");
                                            // fetchedData
                                            //     .sendMessages(
                                            //         fetchedData
                                            //             .fetchedThread.id,
                                            //         _textEditingController.text)
                                            // .whenComplete(() => fetchedData
                                            //         .fetchMessageThreadsById(
                                            //       fetchedData
                                            //           .fetchedThread.id,
                                            //     ));

                                            Future.wait([
                                              fetchedData.sendMessages(
                                                  fetchedData.fetchedThread.id,
                                                  _textEditingController.text),
                                              fetchedData
                                                  .fetchMessageThreadsById(
                                                fetchedData.fetchedThread.id,
                                              )
                                            ]);
                                            isButtonEnabled = false;
                                          }
                                          setState(() {
                                            Future.delayed(const Duration(
                                                    milliseconds: 2000))
                                                .then((value) {
                                              isLoading = false;

                                              _textEditingController.text = '';
                                            });
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
                                              : MaterialStateProperty.all(
                                                  Colors.white),
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
                                        onClicked: selectFile,
                                      ),
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
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
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
