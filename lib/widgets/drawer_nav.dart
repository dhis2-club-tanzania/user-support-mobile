import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/create_message.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(''),
          ),
          ListTile(
            title: const Text('Inbox'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const CreateMessagePage();
                },
              ));
            },
          ),
          ListTile(
            title: const Text('Validation'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const CreateMessagePage();
                },
              ));
            },
          ),
          ListTile(
            title: const Text('Ticket'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const CreateMessagePage();
                },
              ));
            },
          ),
          ListTile(
            title: const Text('System'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const CreateMessagePage();
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
