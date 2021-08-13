import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/categories_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key, required this.title}) : super(key: key);

  final String title;

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
          listTileButtons('Home', Icons.home, '4', context),
          listTileButtons('Inbox', Icons.inbox, '20', context),
          listTileButtons('Validation', Icons.verified, '10', context),
          listTileButtons('Ticket', Icons.document_scanner, '10', context),
          listTileButtons('System', Icons.document_scanner, '10', context),
        ],
      ),
    );
  }
}

Widget listTileButtons(
    String title, IconData icon, String count, BuildContext context) {
  return ListTile(
    title: Text(title),
    leading: Icon(icon),
    trailing: Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color(0xFF1D5288),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          )),
      child: Text(
        count,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    onTap: () => Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const CategoriesPage(categories: 'VALIDATION_RESULT');
      },
    )),
  );
}
