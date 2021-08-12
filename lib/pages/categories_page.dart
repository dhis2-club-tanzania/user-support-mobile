import 'package:flutter/material.dart';

class CreateMessagePage extends StatefulWidget {
  const CreateMessagePage({Key? key}) : super(key: key);

  @override
  _CreateMessagePageState createState() => _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Message'),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.9,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'To',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
