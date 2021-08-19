import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/models/message_conversation.dart';
import 'package:user_support_mobile/models/user_messages.dart';
import 'package:user_support_mobile/providers/provider.dart';

class ReplyPage extends StatefulWidget {
  const ReplyPage({Key? key, required this.messageId}) : super(key: key);

  final String messageId;

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final _replyData = Provider.of<MessageModel>(context);
    context.read<MessageModel>().fetchReply(widget.messageId);
    // var value = context.

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
          _replyData.userReply.displayName,
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
                // _wrapper(_replyData.userReply.userMessages),
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
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // value.sendMessages();
                        print(_textEditingController.text);
                      },
                      child: const Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Reply'),
                      ),
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
                _messageThread(_replyData.userReply),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageThread(MessageConversation messagesData) {
    return Flexible(
      child: ListView.builder(
          itemCount: messagesData.userMessages!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                trailing: Text(messagesData.lastUpdated.substring(0, 10)),
                title: Text(
                    'Message from ${messagesData.userMessages![index].users!.displayName}'),
                subtitle: Text(messagesData.displayName),
                isThreeLine: true,
              ),
            );
          }),
    );
  }

  Widget _wrapper(List<UserMessages>? users) {
    return ListView.builder(itemBuilder: (context, index) {
      return Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: <Widget>[
          Chip(
            label: Text(users![index].users!.displayName),
          ),
        ],
      );
    });
  }
}
