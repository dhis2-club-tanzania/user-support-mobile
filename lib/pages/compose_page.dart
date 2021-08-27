import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../widgets/attachment_button.dart';
import '../widgets/search.dart';

class ComposePage extends StatefulWidget {
  const ComposePage({Key? key}) : super(key: key);

  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  File? file;

  bool isVisible = true;
  bool isButtonEnabled = false;
  final TextEditingController _textEditingController = TextEditingController();

  bool isChecked = false;

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
        title: const Text(
          "Compose",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      width: size.width * 0.6,
                      child: Container(
                        child: TextFormField(
                          onTap: () {
                            showSearch(
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
                          },
                          decoration: const InputDecoration(
                            hintText: "To",
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
                        onPressed: () {
                          showSearch(
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
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      value: isChecked,
                      shape: CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Private Message',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Checkbox(
                      
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      value: isChecked,
                      shape: CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Text(
                      'Feedback',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    )
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
                      hintText: "Subject",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                file != null
                    ? Text(
                        fileName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    : Container(),
                SizedBox(height: 8),
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
                              replyData.AddNewMessage(fileName);
                            }
                            setState(() {
                              _textEditingController.text = '';
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Send',
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
                          icon: Icons.attachment_rounded,
                          text: '',
                          onClicked: selectFile,
                          isButtonEnabled: isButtonEnabled,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
