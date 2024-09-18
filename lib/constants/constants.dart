import 'package:flutter/material.dart';

//const String baseUrl = "https://admin:district@play.dhis2.org/2.36.3/api";

const List<Map<String, dynamic>> menuItems = [
  {
    'name': 'Menu',
    'items': [
      {
        'name': 'Form Requests',
        'icon': Icons.document_scanner_sharp,
        'route': 'dataset',
      },
      {
        'name': 'User account',
        'icon': Icons.person,
        'route': 'user_account',
      },
      // {
      //   'name': 'Programs',
      //   'icon': Icons.add_chart_outlined,
      //   'route': 'programs'
      // },
    ]
  }
];