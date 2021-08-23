import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/models/message_conversation.dart';
import 'package:user_support_mobile/models/user_messages.dart';
import 'package:user_support_mobile/providers/provider.dart';
import 'package:user_support_mobile/widgets/search.dart';

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
    final replyData = Provider.of<MessageModel>(context);
    // context.read<MessageModel>().fetchReply(widget.messageId);
    // var value = context.
    final datas = replyData.findById(widget.messageId);

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
          datas.displayName,
          style: const TextStyle(
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
                buildParticipantsList(datas.userMessages),
                // _participants(datas.userMessages),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: size.width * 0.05),
                        width: size.width * 0.6,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Add New Participant",
                            hintStyle: TextStyle(
                              fontSize: 15,
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
                Container(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async{
                          await replyData.sendMessages(
                              widget.messageId, _textEditingController.text);
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
                ),
                SizedBox(height: 22),
                _messageThread(datas),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _messageThread(MessageConversation? messagesData) {
    return messagesData != null
        ? Flexible(
            child: ListView.builder(
                itemCount: messagesData.messages!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Card(
                      child: ListTile(
                        trailing: Text(messagesData.messages![index].lastUpdated
                            .substring(0, 10)),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                              'Message from ${messagesData.messages![index].sender.displayName}'),
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
                }),
          )
        : Center(child: CircularProgressIndicator());
  }
}

Widget _participantsWrapper(List<UserMessages>? users) {
  return Expanded(
    child: ListView(
        scrollDirection: Axis.horizontal,
        primary: true,
        shrinkWrap: true,
        children: <Widget>[
          Wrap(
            spacing: 4.0,
            runSpacing: 0.0,
            children: List<Widget>.generate(
                users!.length, // place the length of the array here
                (int index) {
              return Chip(label: Text(users[index].users!.displayName));
            }).toList(),
          )
        ]),
  );
}

Widget _participants(List<UserMessages>? users) {
  return Container(
    height: 35,
    child: Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: users!.length,
          itemBuilder: (context, index) {
            return Chip(label: Text(users[index].users!.displayName));
          }),
    ),
  );
}

Widget buildParticipantsList(List<UserMessages>? users) {
  return Container(
    height: 105,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: -1,
        direction: Axis.vertical,
        children: users!
            .map((element) => Container(
                // margin: EdgeInsets.symmetric(horizontal: 5),
                width: 130,
                height: 30,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xFFE0E0E0),
                ),
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Text(element.users!.displayName,
                    textAlign: TextAlign.center)))
            .toList(),
      ),
    ),
  );
}
