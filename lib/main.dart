import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ),
    );
  }
}
