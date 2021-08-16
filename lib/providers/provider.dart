import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:user_support_mobile/constants/constants.dart';
import 'package:user_support_mobile/models/message_conversation.dart';

class MessageModel with ChangeNotifier {
  List<MessageConversation> _allMessageConversation = [];
  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  List<MessageConversation> get allMessageConversation =>
      _allMessageConversation;

  Future<void> get fetchAllMessageConversations async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/33/messageConversations?fields=user,displayName,subject,messageType,messageConversation'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    final list =
        json.decode(response.body)['messageConversations'] as List<dynamic>;
    if (response.statusCode == 200) {
      try {
        _map = jsonDecode(response.body) as Map<String, dynamic>;
        _allMessageConversation = list
            .map((model) =>
                MessageConversation.fromJson(model as Map<String, dynamic>))
            .toList();
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = {};
        _allMessageConversation = [];
      }
    } else {
      _error = true;
      _errorMessage = "Failed to fetch Data";
      _map = {};
      _allMessageConversation = [];
    }
    notifyListeners();
  }

  void initialValue() {
    _allMessageConversation = [];
    _map = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }
}
