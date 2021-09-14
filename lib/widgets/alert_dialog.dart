import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  const ShowDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Text('Are you sure?'),
        content: Text(
          'Do you want to delete?',
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('No'),
          ),
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('deleted message'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {},
                  ),
                ),
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          )
        ],
      ),
    );
  }
}
