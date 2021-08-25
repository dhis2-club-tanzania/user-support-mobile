import 'package:flutter/material.dart';

import 'package:user_support_mobile/pages/home_page.dart';
import 'package:user_support_mobile/pages/inbox_page.dart';
import 'package:user_support_mobile/pages/system_page.dart';
import 'package:user_support_mobile/pages/ticket_page.dart';
import 'package:user_support_mobile/pages/validation_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.all(0.0),
            padding: const EdgeInsets.all(0.0),
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.rectangle,
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.grey.shade500, width: .2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'DHIS2',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFF1D5288),
                    radius: 20,
                    child: Text(
                      'J',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Inbox'),
            leading: Icon(Icons.inbox),
            trailing: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xFF1D5288),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const InboxPage();
              },
            )),
          ),
        ],
      ),
    );
  }
}
