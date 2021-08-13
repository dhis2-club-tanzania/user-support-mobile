import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/home_page.dart';
import 'package:user_support_mobile/pages/reply_page.dart';
import 'package:user_support_mobile/pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Support App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: const Color(0xFF1D5288),
      ),
      home: SplashScreen(),
    );
  }
}
