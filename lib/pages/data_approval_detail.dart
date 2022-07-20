import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/approve_model.dart';
import '../models/message_conversation.dart';
import '../providers/provider.dart';

class DataApprovalDetailPage extends StatefulWidget {
  const DataApprovalDetailPage({Key? key, required this.dataApproval})
      : super(key: key);
  final ApproveModel? dataApproval;

  @override
  DataApprovalDetailPageState createState() => DataApprovalDetailPageState();
}

class DataApprovalDetailPageState extends State<DataApprovalDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContent(
        dataApproval: widget.dataApproval!,
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  const PageContent({Key? key, required this.dataApproval}) : super(key: key);
  final ApproveModel dataApproval;

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  File? file;
  String? selectedUser;
  bool isVisible = true;
  bool isButtonEnabled = false;
  final TextEditingController _textEditingController = TextEditingController();

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
    final provider = Provider.of<MessageModel>(context);
    // final datas = fetchedData.fetchedThread;
    // final messageId = datas.id;
    // bool isLoading = fetchedData.isLoading;

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
            body: SafeArea(
              child: Center(
                child: Container(
                  height: size.height,
                  width: size.width * 0.9,
                  child: ListView(
                    children: [
                      Text(
                        widget.dataApproval.message!.subject!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.dataApproval.message!.subject!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.dataApproval.message!.message!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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

                      const SizedBox(height: 8),
                      Container(
                        child: Row(
                          children: [
                            AbsorbPointer(
                              absorbing: false,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFF235EA0)),
                                ),
                                onPressed: () {

                                  showDataAlert();
                                  context
                                      .read<MessageModel>()
                                      .approvalRequest(widget.dataApproval);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.white),
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
                                      MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed: () {
                                  showDataAlert( );
                                },
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
          ),
        ),
        // if (isLoading)
        //   SizedBox(
        //     width: size.width,
        //     height: size.height,
        //     child: AbsorbPointer(
        //       absorbing: isLoading,
        //       child: Container(
        //         color: Colors.white.withOpacity(0.2),
        //         child: Center(
        //             child: CircularProgressIndicator(
        //           strokeWidth: 10,
        //         )),
        //       ),
        //     ),
        //   )
        // else
        //   Container(),
      ],
    );

    
  }
  showDataAlert() {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: EdgeInsets.only(
            top: 10.0,
          ),
       
          content: Container(
            height: 300,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                 
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                       minLines: 5,
              maxLines: 8, 
                      decoration: InputDecoration(
                        
                          border: OutlineInputBorder(),
                          hintText: 'Reasons',),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.black,
                        // fixedSize: Size(250, 50),
                      ),
                      child: Text(
                        "Confirm",
                      ),
                    ),
                  ),
              
                ],
              ),
            ),
          ),
        );
      });
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
