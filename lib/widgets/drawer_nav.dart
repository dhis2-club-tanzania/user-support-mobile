import 'package:d2_touch/d2_touch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/pages/data_approval_screen.dart';
import 'package:user_support_mobile/pages/login_page.dart';

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
            fetchedData.privateMessages
                .where((product) => product.read == false)
                .length,
            Icons.inbox,
            Colors.green.shade200,
            () => const InboxPage(),
          ),
          _listTileWidget(
              context,
              'Validation',
              fetchedData.validationMessage
                  .where((product) => product.read == false)
                  .length,
              Icons.verified_sharp,
              Colors.blue.shade200,
              () => const ValidationPage()),
          _listTileWidget(
              context,
              'Ticket',
              fetchedData.ticketMessage
                  .where((product) => product.read == false)
                  .length,
              Icons.scanner,
              Colors.red.shade200,
              () => const TicketPage()),
          _listTileWidget(
              context,
              'System',
              fetchedData.systemMessage
                  .where((product) => product.read == false)
                  .length,
              Icons.system_update,
              Colors.pinkAccent,
              () => const SystemPage()),
          _listTileWidget(
              context,
              'Data Approval',
              fetchedData.systemMessage
                  .where((product) => product.read == false)
                  .length,
              Icons.done,
              Colors.pinkAccent,
              () => const DataApprovalScreen(),
              isDataApproval: true),
          TextButton.icon(
              onPressed: () async {
                var logOut = await D2Touch.logOut();
                if (logOut) {
                  Navigator.pushNamed(context, LoginPage.routeName);
                }
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('logout'))
        ],
      ),
    );
  }

  Widget _listTileWidget(BuildContext context, String title, int count,
      IconData icon, Color? color, Widget Function() page,
      {bool? isDataApproval = false}) {
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
