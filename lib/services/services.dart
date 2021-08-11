import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:user_support_mobile/constants/constants.dart';
import 'package:user_support_mobile/models/message.dart';

List<Message> parsed(String responseBody) {
  final list =
      json.decode(responseBody)['messageConversations'] as List<dynamic>;
  return list
      .map((model) => Message.fromJson(model as Map<String, dynamic>))
      .toList();
}

Future<List<Message>> fetchMessages() async {
  final response = await http.get(
      Uri.parse(
          '$baseUrl/33/messageConversations?fields=user,displayName,subject,messageType,messageConversation'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

  if (response.statusCode == 200) {
    return compute(parsed, response.body);
  } else {
    throw Exception('Failed to load Data');
  }
}
