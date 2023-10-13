// ignore_for_file: file_names

import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/models/login-response.model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_support_mobile/widgets/text_widgets/text_widget.dart';

import '../../../constants/d2-repository.dart';
import '../../../helpers/app_helper.dart';
import '../../../pages/home_page.dart';
import '../../../widgets/loaders/circular_progress_loader.dart';
import '../metadatasync/initial-metadata-sync.dart';

class HomeLogin extends StatefulWidget {
  const HomeLogin({Key? key}) : super(key: key);

  static const String routeName = '/login-page';

  @override
  State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  String username = '';
  String password = '';
  String url = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  bool authenticating = false;
  bool showPassWord = false;
  bool loggedIn = true;
  bool errorLoginIn = false;
  late String errorMessage;

  @override
  void initState() {
    usernameController.text = "goodluckwile";
    passwordController.text = "Hmis@2023";
    urlController.text = "http://41.59.227.69/tland";
    // urlController.text = "https://eidsrtesting.mohz.go.tz/test";
    // urlController.text = "https://eidsr.moh.go.tz/test";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ignore: todo
        //TODO : add logic to check if back will go to login page

        showAppClosingDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.background),
          width: double.maxFinite,
          height: double.maxFinite,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 120),
                alignment: Alignment.center,
                child: TextWidgetBold(
                  text: 'User support',
                  size: 30,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 30, right: 20, left: 20),
                  margin: const EdgeInsets.only(left: 40, right: 40, top: 20),
                  child: Container(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                        children: [
                          errorLoginIn
                              ? Text(
                                  errorMessage,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error),
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.person_outlined),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Username',
                                ),
                              )),
                          Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 25),
                              child: TextFormField(
                                obscureText: !showPassWord,
                                controller: passwordController,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  // suffixIcon: Icon(Icons.person,),
                                  suffixIcon: IconButton(
                                    icon: showPassWord
                                        ? const Icon(Icons.visibility_sharp)
                                        : const Icon(
                                            Icons.visibility_off_outlined),
                                    onPressed: () {
                                      setState(() {
                                        showPassWord = !showPassWord;
                                      });
                                    },
                                  ),
                                  border: const UnderlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              )),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: (Colors.blue),
                              minimumSize: const Size.fromHeight(45), // NEW
                            ),
                            onPressed: () async {
                              setState(() {
                                username = usernameController.text.trim();
                                password = passwordController.text.trim();
                                url = urlController.text;
                                authenticating = true;
                                errorMessage = "";
                                errorLoginIn = false;
                              });
                              if (await AppHelpers.isConnected()) {
                                _login(username, password, url);
                                return;
                              }
                              setState(() {
                                authenticating = false;
                                errorMessage = "No active internet connection";
                                errorLoginIn = true;
                              });
                              AppHelpers.noInternetWarning();
                            },
                            child: authenticating == false
                                ? const Text("Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))
                                : const CircularProgressLoader(
                                    "Authenticating", null),
                          ),

                          // AppHelpers.getVersionDetails()
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }

  showAppClosingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            children: [
              const SimpleDialogOption(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    "This action will close the app, proceed to close the app?",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              )),
              SimpleDialogOption(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Close App   ",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.redAccent)),
                  ),
                ],
              )),
            ],
          );
        });
  }

  _login(String username, String password, String url) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    setState(() {
      authenticating = true;
    });

    // ignore: unused_local_variable
    LoginResponseStatus? onlineLogIn;

    try {
      onlineLogIn = await d2repository.authModule
          .logIn(username: username, password: password, url: url);
      d2repository = await D2Touch.init();
    } catch (error) {
      setState(() {
        onlineLogIn = null;
        errorLoginIn = true;
        authenticating = false;
        errorMessage =
            'Error logging in. Please confirm your credentials and retry';
      });
    }

    bool isAuthenticated = await d2repository.authModule.isAuthenticated();

    if (isAuthenticated) {
      User? loggedInUser =
          await d2repository.userModule.user.withAuthorities().getOne();
      setState(() => {
            appUser = loggedInUser,
            authenticating = false,
            loggedIn = false,
            errorLoginIn = false,
          });

      // ignore: todo
      // TODO: revamp metadata sync page

      await Get.to(() => HomeMetadataSync(
            loggedInUser: appUser,
          ));

      await Get.toNamed(HomePage.routeName);
    } else {
      //logic to show error widget

      setState(() => {
            authenticating = false,
            loggedIn = false,
            errorLoginIn = true,
            errorMessage = "error message"
          });
    }
  }
}
