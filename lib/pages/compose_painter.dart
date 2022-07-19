import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../widgets/attachment_button.dart';
import '../widgets/search.dart';

class ComposePainter extends StatefulWidget {
  const ComposePainter({Key? key}) : super(key: key);
  static const String routeName = '/page-testing';

  @override
  ComposePainterState createState() => ComposePainterState();
}

class ComposePainterState extends State<ComposePainter> {
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
    bool isLoading = fetchedData.isLoading;

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
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
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
                                    // fetchedData
                                    //     .queryUserGroups(query)
                                    //     .whenComplete(
                                    //       () => fetchedData
                                    //           .queryOrgarnizationUnits(query)
                                    //           .whenComplete(
                                    //             () => fetchedData
                                    //                 .queryUser(query),
                                    //           ),
                                    //     );
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
                                    // fetchedData.addParticipant();
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
                        Column(
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
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
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
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
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
                                        ? MaterialStateProperty.all(
                                            Color(0xFFE0E0E0))
                                        : MaterialStateProperty.all(
                                            Color(0xFF235EA0)),
                                  ),
                                  onPressed: () {
                                    if (_textEditingController.text.trim() !=
                                        "") {
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
                                              (_) => fetchedData
                                                  .fetchPrivateMessages,
                                            );
                                      }
                                      if (isFeedback) {
                                        fetchedData
                                            .addFeedbackMessage(
                                                _textEditingController1.text,
                                                _textEditingController.text)
                                            .then(
                                              (_) => fetchedData
                                                  .fetchPrivateMessages,
                                            );
                                        print("Iversion");
                                      }

                                      isButtonEnabled = false;
                                    }
                                    setState(() {
                                      Future.delayed(const Duration(
                                              milliseconds: 2000))
                                          .then((value) {
                                        isLoading = false;
                                        _textEditingController1.text = '';

                                        _textEditingController.text = '';
                                      });
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Send',
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
                                        ? MaterialStateProperty.all(
                                            Color(0xFFE0E0E0))
                                        : MaterialStateProperty.all(
                                            Colors.white),
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
              )),
        ),
        if (isLoading)
          SizedBox(
            width: size.width,
            height: size.height,
            child: AbsorbPointer(
              absorbing: isLoading,
              child: Container(
                color: Colors.white.withOpacity(0.2),
                child: const Center(
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
