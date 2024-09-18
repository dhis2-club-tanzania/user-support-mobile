import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'data_approval_screen.dart';

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
                onPressed: () async {
                  //await context.read<MessageModel>().fetchDataApproval;
                  context.go('/home/dataset');
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
                        widget.dataApproval.message!.subject!.split("-").last,
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
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                  // showDataAlert(context, isAccept: true);
                                  _loading();
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
                                  showDataAlert(context);
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

  void _loading({bool isAccept = false}) async {
    EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black); // code to show modal with masking
    if (isAccept) {
      await context.read<MessageModel>().approvalRequest(widget.dataApproval);
      // Navigator.of(context).pop();
    } else {
      await context.read<MessageModel>().approvalRequest(widget.dataApproval,
          message: _textEditingController.text.trim());
    }
    await context.read<MessageModel>().approvalRequest(widget.dataApproval);
    bool loading = context.read<MessageModel>().isLoading;
    // var data = await LoginAPI.connectToAPI(
    //     emailController.text, passwordController.text);
    if (!loading) {
      EasyLoading.showSuccess(
          'Success!'); // code to show modal without masking and auto close
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     DataApprovalScreen.routeName, (Route<dynamic> route) => false);

      context.pushReplacement('/home');
    }
  }
// .

  showDataAlert(BuildContext context, {bool isAccept = false}) {
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
                        onPressed: () async {
                          if (isAccept) {
                            context
                                .read<MessageModel>()
                                .approvalRequest(widget.dataApproval);
                            // Navigator.of(context).pop();
                          } else {
                            // context.read<MessageModel>().approvalRequest(
                            //     widget.dataApproval,
                            //     message: _textEditingController.text.trim());
                            // context.read<MessageModel>().approvalRequest(
                            //     widget.dataApproval,
                            //     message: _textEditingController.text.trim());
                            _loading();
                          }
                          await context.read<MessageModel>().fetchDataApproval;
                          // Navigator.of(context).pop();
                          // Future.delayed(const Duration(milliseconds: 500), () {
                          //   Navigator.pushNamed(
                          //       context, DataApprovalScreen.routeName);
                          // });
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