import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/models/login-response.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/d2-repository.dart';
import '../providers/provider.dart';
import 'data_approval_screen.dart';

class LoginPage extends StatefulWidget {
  final bool? isAuth;

  const LoginPage({Key? key, this.isAuth}) : super(key: key);
  static const String routeName = '/login-page32';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    context.read<MessageModel>().fetchValidationMessages;
    Widget nextWidget = Container();

    if (widget.isAuth == true) {
      nextWidget = DataApprovalScreen();
      return nextWidget;
    }
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 100.0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: const Image(
                    color: Color(0xFF1D5288),
                    image: AssetImage('assets/images/dhis2logo.png'),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: _usernameEditingController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'username is required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: _passwordEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                      const Text('Login using two factor authentication')
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: OutlinedButton(
                          style: const ButtonStyle(),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print(_usernameEditingController.text.trim() +
                                  _passwordEditingController.text.trim());
                              LoginResponseStatus loginRes =
                                  await d2repository.authModule.logIn(
                                      url: 'https://tland.dhis2.udsm.ac.tz',
                                      username: _usernameEditingController.text
                                          .trim(),
                                      password: _passwordEditingController.text
                                          .trim());

                              print(loginRes);
                              if (loginRes ==
                                      LoginResponseStatus
                                          .ONLINE_LOGIN_SUCCESS ||
                                  loginRes ==
                                      LoginResponseStatus
                                          .OFFLINE_LOGIN_SUCCESS) {
                                // Navigator.pushReplacementNamed(
                                //     context, InboxPage.routeName);
                                Navigator.pushReplacementNamed(
                                    context, DataApprovalScreen.routeName);

                                if (loginRes ==
                                    LoginResponseStatus.WRONG_CREDENTIALS) {
                                  //wrong credential was provided
                                }
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Forget password?',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      // GestureDetector(
                      //   onTap: () => Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) {
                      //       return const SignUpPage();
                      //     },
                      //   )),
                      //   child: const Text(
                      //     'Create account',
                      //     style: TextStyle(
                      //       color: Colors.black87,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
