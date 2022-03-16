import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/text_theme.dart';
import 'pages/splash_page.dart';
import 'providers/provider.dart';
import 'routes/routes.dart';
import 'main.reflectable.dart';

void main() async {
  initializeReflectable();

  // var loginRes = await D2Touch.logIn(
  //     url: 'https://play.dhis2.org/2.36.9',
  //     username: 'admin',
  //     password: 'district');
  // print(loginRes);
  var isAuth = await D2Touch.isAuthenticated();
  print(isAuth);

  // var logOut = await D2Touch.logOut();
  // print(logOut);

  runApp(
    MyApp(isAuth: isAuth,),
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
        home: SplashScreen(isAuth: isAuth,),
        routes: routes,
      ),
    );
  }
}



//  final res = await HttpClient.get('dataStore/functions');

//   final finalResults =
//       await Future.wait(res.body.map<Future<dynamic>>((id) async {
//     final oneRes = await HttpClient.get('dataStore/functions/$id');

//     return oneRes.body;
//   }).toList());

//   print('DATASTORE RESULTS ${finalResults}');
