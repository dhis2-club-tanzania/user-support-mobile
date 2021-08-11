import 'package:flutter/material.dart';

class ReadMessagePage extends StatefulWidget {
  const ReadMessagePage({Key? key}) : super(key: key);

  @override
  _ReadMessagePageState createState() => _ReadMessagePageState();
}

class _ReadMessagePageState extends State<ReadMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject of mail'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: const [Text('Mail Subject')],
          ),
        ),
      ),
    );
  }
}
