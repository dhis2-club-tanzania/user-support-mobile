import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/inbox_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InboxPage(),
    );
  }
}
