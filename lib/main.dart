import 'package:d2_touch/d2_touch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:user_support_mobile/constants/d2-repository.dart';

import '../helpers/text_theme.dart';
import 'main.reflectable.dart';
import 'pages/splash_page.dart';
import 'providers/provider.dart';
import 'routes/routes.dart';

void main() async {
  initializeReflectable();
  WidgetsFlutterBinding.ensureInitialized();
  d2repository = await D2Touch.init();

  // for development purposes
  var loginRes = await d2repository.authModule.logIn(
    url: 'http://41.59.227.69/tland',
    username: 'pt',
    password: 'Dhis.2022',
  );

  print(loginRes);

  var isAuth = await d2repository.authModule.isAuthenticated();

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
        builder: EasyLoading.init(),
      ),
    );
  }
}
