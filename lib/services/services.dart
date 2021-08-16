import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:user_support_mobile/constants/constants.dart';
import 'package:user_support_mobile/models/message_conversation.dart';

Future<List<MessageConversation>> fetchMessages() async {
  final response = await http.get(
      Uri.parse(
          '$baseUrl/33/messageConversations?fields=user,displayName,subject,messageType,messageConversation'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
  final list =
      json.decode(response.body)['messageConversations'] as List<dynamic>;

  if (response.statusCode == 200) {
    return list
        .map((model) =>
            MessageConversation.fromJson(model as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load Data');
  }
}
