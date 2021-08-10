import 'package:flutter/material.dart';

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
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Validation'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Ticket'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('System'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
