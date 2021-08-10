import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:user_support_mobile/constants/constants.dart';
import 'package:user_support_mobile/models/message.dart';

Future<Message> fetchAllMessage() async {
  final response = await http.get(
    Uri.parse(
        '$baseUrl/api/33/messageConversations?fields=user,displayName,subject,messageType'),
  );
  print(jsonDecode(response.body));

  if (response.statusCode == 200) {
    return Message.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Messages');
  }
}
