import 'package:flutter/material.dart';

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
          initialData: const [],
          future: fetchMessage,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final userData = snapshot.data![index];
                  print(userData.user);

                  return userData.user != null ? Center(
                    child: MessageCardWidget(
                        thumbnail: const CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            'J',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        userName: userData.user!.id,
                        subject: userData.subject,
                        messageContent: userData.displayName,
                        publishDate: '20 may',
                        readDuration: '2 min ago'),
                  ): Center(child: Text('User information is not defined'),);
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
    );
  }
}
