import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/approve_model.dart';
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

  @override
  Widget build(BuildContext context) {
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
                                    Color(0xFF235EA0),
                                  ),
                                ),
                                onPressed: () {
                              showDataAlert(isAccept: true);
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
                                  showDataAlert();
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

  showDataAlert({bool isAccept = false}) {
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
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            content: Container(
              // height: 300,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (!isAccept)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textEditingController,
                          minLines: 3,
                          maxLines: 8,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Reasons',
                          ),
                        ),
                      ),
                        if (isAccept)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                       'You are about to accept.',
                          
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (isAccept) {
                            context
                                .read<MessageModel>()
                                .approvalRequest(widget.dataApproval);
                            Navigator.of(context).pop();
                          } else {
                            context.read<MessageModel>().approvalRequest(
                                widget.dataApproval,
                                message: _textEditingController.text.trim());
                            Navigator.of(context).pop();
                          }
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
}
