import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/pages/compose_page.dart';
import 'package:user_support_mobile/pages/inbox_page.dart';
import 'package:user_support_mobile/pages/system_page.dart';
import 'package:user_support_mobile/pages/ticket_page.dart';
import 'package:user_support_mobile/pages/validation_page.dart';

import './pages/splash_page.dart';
import './providers/provider.dart';

void main() {
runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageModel>(
      create: (_) => MessageModel(),
      child: MaterialApp(
        title: 'User Support App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: const Color(0xFF1D5288),
        ),
        home: SplashScreen(),
          routes: {
            InboxPage.routeName: (ctx) => InboxPage(),
            SystemPage.routeName: (ctx) => SystemPage(),
            ValidationPage.routeName: (ctx) => ValidationPage(),
            ComposePage.routeName: (ctx) => ComposePage(),
            TicketPage.routeName: (ctx) => TicketPage(),
          }
      ),
    );
  }
}
