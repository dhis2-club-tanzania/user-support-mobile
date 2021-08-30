import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '/pages/inbox_page.dart';
import '/pages/system_page.dart';
import '/pages/ticket_page.dart';
import '/pages/validation_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fetchedData = Provider.of<MessageModel>(context);

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
          _listTileWidget(
            context,
            'Inbox',
            fetchedData.privateMessages.length,
            Icons.inbox,
            Colors.green.shade200,
            () => const InboxPage(),
          ),
          _listTileWidget(
              context,
              'Validation',
              fetchedData.validationMessage.length,
              Icons.verified_sharp,
              Colors.blue.shade200,
              () => const ValidationPage()),
          _listTileWidget(context, 'Ticket', 5, Icons.scanner,
              Colors.red.shade200, () => const TicketPage()),
          _listTileWidget(context, 'System', 4, Icons.system_update,
              Colors.pinkAccent, () => const SystemPage()),
        ],
      ),
    );
  }

  Widget _listTileWidget(
    BuildContext context,
    String title,
    int count,
    IconData icon,
    Color? color,
    Widget Function() page,
  ) {
    return ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              )),
          child: Text(
            "$count new",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return page();
            },
          ));
        });
  }
}
