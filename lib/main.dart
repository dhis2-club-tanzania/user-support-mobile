import 'package:d2_touch/d2_touch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/text_theme.dart';
import 'main.reflectable.dart';
import 'pages/splash_page.dart';
import 'providers/provider.dart';
import 'routes/routes.dart';

void main() async {
  initializeReflectable();
  // D2Touch.initialize();

  var loginRes = await D2Touch.logIn(
    url: 'https://tland.dhis2.udsm.ac.tz',
    username: 'pt',
    password: 'Dhis.2022',
  );

  print(loginRes);

  var isAuth = await D2Touch.isAuthenticated();
  print(isAuth);

  runApp(
    MyApp(
      isAuth: isAuth,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isAuth;

  const MyApp({Key? key, this.isAuth}) : super(key: key);
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
        home: SplashScreen(isAuth: isAuth),
        routes: routes,
      ),
    );
  }
}
