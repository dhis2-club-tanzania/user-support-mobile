import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:user_support_mobile/constants/constants.dart';
import 'package:user_support_mobile/models/message_conversation.dart';

class MessageModel with ChangeNotifier {
  List<MessageConversation> _allMessageConversation = [];
  List<MessageConversation> _privateMessages = [];
  List<MessageConversation> _replay = [];

  Map<String, dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  List<MessageConversation> get allMessageConversation =>
      _allMessageConversation;
  List<MessageConversation> get privateMessages => _privateMessages;
  List<MessageConversation> get userReply => _replay;

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

  // Future<void> get fetchAllUsers async {
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/33/users/'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //   );

  //   final list = json.decode(response.body)['users'] as List<dynamic>;
  //   if (response.statusCode == 200) {
  //     try {
  //       _map = jsonDecode(response.body) as Map<String, dynamic>;
  //       _allUsers = list
  //           .map((model) => User.fromJson(model as Map<String, dynamic>))
  //           .toList();
  //       _error = false;
  //     } catch (e) {
  //       _error = true;
  //       _errorMessage = e.toString();
  //       _map = {};
  //       _allUsers = [];
  //     }
  //   } else {
  //     _error = true;
  //     _errorMessage = "Failed to fetch Data";
  //     _map = {};
  //     _allUsers = [];
  //   }
  //   notifyListeners();
  // }

  Future<void> sendMessages() async {
    final response = await http.post(
      Uri.parse('$baseUrl/33/messageConversations/qXF4GmtZZrE'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "subject": "This is was a real deal",
        "text": "How are you?",
        "users": [
          {"id": "OYLGMiazHtW"},
          {"id": "N3PZBUlN8vq"}
        ],
        "userGroups": [
          {"id": "ZoHNWQajIoe"}
        ],
        "organisationUnits": [
          {"id": "DiszpKrYNg8"}
        ]
      }),
    );
    print('this is a body');
    print(response.body);
    if (response.statusCode == 201) {
      print('The post was successful');
    } else {
      print('failed to post data');
    }
    notifyListeners();
  }

  Future<void> get fetchPrivateMessages async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/33/messageConversations?filter=messageType%3Aeq%3APRIVATE&pageSize=35&page=1&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.statusCode);
    print('-----start of catch block');
    final list =
        json.decode(response.body)['messageConversations'] as List<dynamic>;
    if (response.statusCode == 200) {
      print(list);
      try {
        _map = jsonDecode(response.body) as Map<String, dynamic>;
        _privateMessages = list
            .map((model) =>
                MessageConversation.fromJson(model as Map<String, dynamic>))
            .toList();
        print(_privateMessages);
        _error = false;
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _map = {};
        _allMessageConversation = [];
      }
      print('-----end of catch block');
    } else {
      _error = true;
      _errorMessage = "Failed to fetch Data";
      _map = {};
      _allMessageConversation = [];
    }
    notifyListeners();
  }

  // Future<void> fetchReply(String id) async {
  //   final response = await http.get(
  //     Uri.parse(
  //         '$baseUrl/33/messageConversations/$id?fields=*,assignee%5Bid%2C%20displayName%5D,messages%5B*%2Csender%5Bid%2CdisplayName%5D,attachments%5Bid%2C%20name%2C%20contentLength%5D%5D,userMessages%5Buser%5Bid%2C%20displayName%5D%5D'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     },
  //   );

  //   final list = json.decode(response.body) as List<dynamic>;
  //   if (response.statusCode == 200) {
  //     _map = jsonDecode(response.body) as Map<String, dynamic>;
  //     _replay = list
  //         .map((model) =>
  //             MessageConversation.fromJson(model as Map<String, dynamic>))
  //         .toList();
  //     _error = false;
  //   } else {
  //     throw 'failed to load Data';
  //   }
  //   notifyListeners();
  // }

  void initialValue() {
    _allMessageConversation = [];
    _map = {};
    _error = false;
    _errorMessage = '';

    notifyListeners();
  }
}
