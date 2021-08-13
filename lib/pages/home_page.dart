import 'package:flutter/material.dart';

import 'package:user_support_mobile/pages/compose_page.dart';
import 'package:user_support_mobile/pages/reply_page.dart';
import 'package:user_support_mobile/widgets/page_content.dart';

import '../models/message_conversation.dart';
import '../services/services.dart';
import '../widgets/drawer_nav.dart';

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

                  return userData.user != null
                      ? Center(
                          child: PageContentWidget(data: userData),
                        )
                      : Center(
                          child: AltenativePageContentWidget(data: userData),
                        );
                },
              );
            } else if (snapshot.connectionState != ConnectionState.done) {
              return Text('${snapshot.error}');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      drawer: const NavigationDrawer(
        title: '',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComposePage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
