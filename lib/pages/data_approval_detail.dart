import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../models/message_conversation.dart';
import '../providers/provider.dart';

class DataApprovalDetailPage extends StatefulWidget {
  const DataApprovalDetailPage({Key? key}) : super(key: key);

  @override
  DataApprovalDetailPageState createState() => DataApprovalDetailPageState();
}

class DataApprovalDetailPageState extends State<DataApprovalDetailPage> {
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
                              SizedBox(
                                height: 20,
                              ),
                              _messageThread(datas),
                              // Container(
                              //   padding:
                              //       EdgeInsets.only(left: size.width * 0.05),
                              //   width: size.width,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(1),
                              //       border: Border.all(color: Colors.black26)),
                              //   child: TextFormField(
                              //     onFieldSubmitted: null,
                              //     controller: _textEditingController,
                              //     maxLines: null,
                              //     keyboardType: TextInputType.multiline,
                              //     expands: true,
                              //     style: const TextStyle(
                              //       fontSize: 18,
                              //       color: Colors.black,
                              //     ),
                              //     onChanged: (val) {
                              //       isEmpty();
                              //     },
                              //     decoration: const InputDecoration(
                              //       border: InputBorder.none,
                              //       hintText: "Compose reply",
                              //     ),
                              //   ),
                              // ),
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
                                      absorbing: false,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color(0xFF235EA0)),
                                        ),
                                        onPressed: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            'Accept',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    AbsorbPointer(
                                      absorbing: false,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                        ),
                                        onPressed: () {},
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Reject',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
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
