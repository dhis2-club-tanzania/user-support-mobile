import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/pages/inbox_page.dart';
import '/providers/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   

    return const Scaffold(
      body: InboxPage(),
    );
  }
}
