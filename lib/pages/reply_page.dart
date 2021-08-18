import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/providers/provider.dart';

class ReplyPage extends StatefulWidget {
  const ReplyPage({Key? key}) : super(key: key);

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
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
                Container(
                  height: 100,
                  child: TextFormField(
                    controller: _textEditingController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Compose message",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Consumer<MessageModel>(
                      builder: (context, value, child) {
                        return ElevatedButton(
                          onPressed: () {
                            value.sendMessages();
                            print(_textEditingController.text);
                          },
                          child: const Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Reply'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Discard'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Icon(Icons.attachment_outlined),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Card(
                  child: ListTile(
                    trailing: Text('20 min'),
                    title: Text('Message from Tom Wakiki'),
                    subtitle: Text('The best ways of the creating words'),
                    isThreeLine: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
