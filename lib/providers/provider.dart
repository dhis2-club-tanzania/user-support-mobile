import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:user_support_mobile/constants/constants.dart';
import 'package:user_support_mobile/models/message_conversation.dart';

class MessageModel with ChangeNotifier {
  List<MessageConversation> _allMessageConversation = [];
  List<MessageConversation> _allMessagesThreads = [];

  List<MessageConversation> _privateMessages = [];
  late MessageConversation _reply;

  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  List<MessageConversation> get allMessageConversation =>
      _allMessageConversation;
  List<MessageConversation> get privateMessages => _privateMessages;
  MessageConversation get userReply => _reply;

  MessageConversation findById(String id) {
    return _allMessagesThreads.firstWhere(
      (thread) => thread.id == id,
      orElse: () => MessageConversation(
        messageCount: '',
        followUp: false,
        lastUpdated: '',
        id: '',
        read: false,
        name: '',
        subject: '',
        displayName: '',
        messageType: '',
        lastMessage: '',
        favorite: false,
        lastSender: null,
        userMessages: null,
      ),
    );
  }

  Future<void> sendAttachment(String filename) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          '$baseUrl/messageConversations?filter=messageType%3Aeq%3APRIVATE&pageSize=35&page=1&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
    );
    request.files.add(await http.MultipartFile.fromPath('picture', filename));
    final res = await request.send();

    print(res);
  }

  Future<void> sendMessages(String id, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations/$id?internal=false'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(message),
    );

    print(response);

    notifyListeners();
  }

  Future<void> get fetchPrivateMessages async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/messageConversations?filter=messageType%3Aeq%3APRIVATE&pageSize=35&page=1&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final list =
        json.decode(response.body)['messageConversations'] as List<dynamic>;
    if (response.statusCode == 200) {
      _map = jsonDecode(response.body) as Map<String, dynamic>;
      _privateMessages = list
          .map((model) =>
              MessageConversation.fromJson(model as Map<String, dynamic>))
          .toList();
      _error = false;
    } else {
      throw Exception("Failed to Load Data");
    }
    notifyListeners();
  }

  Future<void> fetchMessageThreads(String id) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/messageConversations/$id?fields=*,assignee%5Bid%2C%20displayName%5D,messages%5B*%2Csender%5Bid%2CdisplayName%5D,attachments%5Bid%2C%20name%2C%20contentLength%5D%5D,userMessages%5Buser%5Bid%2C%20displayName%5D%5D'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    final Map<String, dynamic> list =
        json.decode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      _allMessagesThreads.add(MessageConversation.fromJson(list));
    } else {
      throw Exception('Failed to Load Data');
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
