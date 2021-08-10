import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: const Color(0xFF1D5288),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 70.0,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // color: const Color(0xFF1D5288),
                padding: const EdgeInsets.only(bottom: 45.0),
                child: const Image(
                  color: Color(0xFF1D5288),
                  image: AssetImage('assets/images/dhis2logo.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                // color: Colors.white,
                width: size.width * 0.8,
                child: const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(10),
                        // ),
                        ),
                    hintText: 'Name',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),

                // color: Colors.white,
                width: size.width * 0.8,
                child: const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(10),
                        // ),
                        ),
                    hintText: 'Username',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                width: size.width * 0.8,
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    hintText: 'Password',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                width: size.width * 0.8,
                child: const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),

                // color: Colors.white,
                width: size.width * 0.8,
                child: const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(10),
                        // ),
                        ),
                    hintText: 'Email Address',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),

                // color: Colors.white,
                width: size.width * 0.8,
                child: const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(10),
                        // ),
                        ),
                    hintText: 'Mobile Number',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                // color: Colors.white,
                width: size.width * 0.8,
                child: const TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(
                        //   Radius.circular(10),
                        // ),
                        ),
                    hintText: 'Employer',
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                ),
              ),
              Container(
                width: size.width * 0.8,
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: const ButtonStyle(),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
