import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider.dart';
import '../pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  final bool? isAuth;

  const SplashScreen({Key? key, this.isAuth}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => LoginPage(
            isAuth: widget.isAuth,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<MessageModel>().fetchPrivateMessages;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dhis2logo.png',
              color: const Color(0xFF1D5288),
              height: 120,
            ),
            const SizedBox(
              height: 20,
            ),
            // const CircularProgressIndicator(
            //   valueColor: AlwaysStoppedAnimation<Color>(
            //     Color(0xFF1D5288),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
