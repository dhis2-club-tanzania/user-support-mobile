// import 'package:flutter/material.dart';
// import 'package:user_support_mobile/pages/home_page.dart';

// import 'package:user_support_mobile/pages/signup_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: const Color(0xFFffffff),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(
//           top: 100.0,
//         ),
//         child: Container(
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(bottom: 60.0),
//                 child: const Image(
//                   color: Color(0xFF1D5288),
//                   image: AssetImage('assets/images/dhis2logo.png'),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 width: size.width * 0.8,
//                 child: const TextField(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Username',
//                     contentPadding: EdgeInsets.all(10.0),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.only(
//                   top: 10.0,
//                   bottom: 20.0,
//                 ),
//                 width: size.width * 0.8,
//                 child: const TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Password',
//                     contentPadding: EdgeInsets.all(10.0),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: size.width * 0.8,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Checkbox(
//                       value: false,
//                       onChanged: (value) {},
//                     ),
//                     const Text('Login using two factor authentication')
//                   ],
//                 ),
//               ),
//               Container(
//                 width: size.width * 0.8,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 10, top: 10),
//                       child: OutlinedButton(
//                         style: const ButtonStyle(),
//                         onPressed: () => Navigator.pushReplacement(context,
//                             MaterialPageRoute(
//                           builder: (context) {
//                             return const HomePage();
//                           },
//                         )),
//                         child: const Padding(
//                           padding: EdgeInsets.all(15.0),
//                           child: Text(
//                             'Sign in',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: size.width * 0.8,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     const Text(
//                       'Forget password?',
//                       style: TextStyle(
//                         color: Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 25.0,
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const SignUpPage();
//                         },
//                       )),
//                       child: const Text(
//                         'Create account',
//                         style: TextStyle(
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
