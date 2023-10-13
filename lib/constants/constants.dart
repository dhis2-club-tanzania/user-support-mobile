import 'package:flutter/material.dart';

const String baseUrl = "https://admin:district@play.dhis2.org/2.36.3/api";

const List<Map<String, dynamic>> menuItems = [
  {
    'name': 'Form requests',
    'items': [
      {'name': 'Organisation units', 'icon': Icons.house},
      {'name': 'Datasets', 'icon': Icons.dataset},
      {'name': 'Programs', 'icon': Icons.add_chart_outlined},
    ]
  },
  {
    'name': 'User accounts',
    'items': [
      {'name': 'Pending requests', 'icon': Icons.email},
      {'name': 'Users', 'icon': Icons.phone},
    ]
  },
  {
    'name': 'Validation Rules request',
    'items': [
      {'name': 'Requests', 'icon': Icons.shopping_cart},
      {'name': 'Requesting', 'icon': Icons.music_note},
    ]
  },
];
