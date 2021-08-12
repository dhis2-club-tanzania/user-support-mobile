import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/compose_page.dart';
import 'package:user_support_mobile/widgets/page_content.dart';

import '../models/message_conversation.dart';
import '../services/services.dart';
import '../widgets/drawer_nav.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key, required this.categories}) : super(key: key);
  final String categories;

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
        title: Text(widget.categories),
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

                  return userData.messageType == widget.categories
                      ? Center(
                          child: PageContentWidget(data: userData),
                        )
                      : Container();
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
            MaterialPageRoute(builder: (context) => ComposePage()),
          );
        },
      ),
    );
  }
}
