import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/splash_page.dart';
import './providers/provider.dart';
import '../helpers/textTheme.dart';
import '../pages/compose_page.dart';
import '../pages/inbox_page.dart';
import '../pages/login_page.dart';
import '../pages/system_page.dart';
import '../pages/ticket_page.dart';
import '../pages/validation_page.dart';

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
          debugShowCheckedModeBanner: false,
          title: 'User Support App',
          theme: ThemeData(
            textTheme: textTheme,
            primaryColor: const Color(0xFF1D5288),
            // accentColor: const Color(0xFF1D5288),
          ),
          home: SplashScreen(),
          routes: {
            InboxPage.routeName: (ctx) => const InboxPage(),
            SystemPage.routeName: (ctx) => const SystemPage(),
            ValidationPage.routeName: (ctx) => const ValidationPage(),
            ComposePage.routeName: (ctx) => const ComposePage(),
            TicketPage.routeName: (ctx) => const TicketPage(),
            LoginPage.routeName: (ctx) => const LoginPage(),
          }),
    );
  }
}
