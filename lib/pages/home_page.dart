import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/new_message.dart';

import '../models/message_conversation.dart';
import '../services/services.dart';
import '../widgets/drawer_nav.dart';
import '../widgets/message_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MessageConversation>> fetchMessage;

  @override
  void initState() {
    super.initState();
    fetchMessage = fetchMessages();
  }

  Widget thumbnail() => Container(
        color: Colors.black12,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'),
        backgroundColor: const Color(0xFF1D5288),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder<List<MessageConversation>>(
          initialData: [],
          future: fetchMessage,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final userData = snapshot.data![index];
                  print(userData.user);

                  return userData.user != null
                      ? Center(
                          child: _pageContent(userData),
                        )
                      : Center(
                          child: _altenativePageContent(userData),
                        );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              // By default, show a loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      drawer: const NavigationDrawer(
        title: 'Javier Kamara',
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewMessage()),
          );
        },
      ),
    );
  }

  Widget _pageContent(MessageConversation data) {
    final String firstLetter =
        data.user!.displayName.substring(0, 1).toUpperCase();
    return MessageCardWidget(
        thumbnail: CircleAvatar(
          backgroundColor: const Color(0xFF1D5288),
          child: Text(
            firstLetter,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        userName: data.user!.displayName,
        subject: data.subject,
        messageContent: data.displayName,
        publishDate: '20 may',
        readDuration: '2 min ago');
  }

  Widget _altenativePageContent(MessageConversation data) {
    return MessageCardWidget(
        thumbnail: const CircleAvatar(
          backgroundColor: Color(0xFF1D5288),
          child: Text(
            'S',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subject: data.subject,
        messageContent: data.displayName,
        publishDate: '20 may',
        readDuration: '2 min ago');
  }
}
