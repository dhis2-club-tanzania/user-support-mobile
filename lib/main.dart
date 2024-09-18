
import 'dart:core';

import 'package:d2_touch/d2_touch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:user_support_mobile/constants/d2-repository.dart';
import 'package:user_support_mobile/providers/provider.dart';
import 'package:user_support_mobile/routes/routes.dart';

import '../helpers/text_theme.dart';
import 'main.reflectable.dart';

void main() async {
  initializeReflectable();
  WidgetsFlutterBinding.ensureInitialized();
  d2repository = await D2Touch.init();

  // for development purposes
  // await d2repository.authModule.logIn(
  //     url: 'http://41.59.227.69/tland-upgrade',
  //     username: 'pt2024',
  //     password: 'Hmis@2024');

  bool isAuth = await d2repository.authModule.isAuthenticated();

  runApp(
    MyApp(
      isAuth: isAuth,
    ),
  );
}



class MyApp extends StatefulWidget {
  final bool isAuth;
  const MyApp({Key? key, required this.isAuth}) : super(key: key);

  

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MessageModel>(
          create: (_) => MessageModel(),
          child: MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            title: 'User Support App',
            theme: ThemeData(
              useMaterial3: false,
              textTheme: textTheme,
              primaryColor: const Color(0xFF1D5288),
            ),
            builder: EasyLoading.init(),
          ));
  }
}

