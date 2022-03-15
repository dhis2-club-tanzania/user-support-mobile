import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/text_theme.dart';
import 'pages/splash_page.dart';
import 'providers/provider.dart';
import 'routes/routes.dart';

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
        ),
        home: SplashScreen(),
        routes: routes,
      ),
    );
  }
}
