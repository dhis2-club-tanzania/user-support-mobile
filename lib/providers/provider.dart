import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:user_support_mobile/constants/constants.dart';
import 'package:user_support_mobile/models/message_conversation.dart';

class MessageModel with ChangeNotifier {
  List<MessageConversation> _allMessageConversation = [];
  late MessageConversation _fetchedThread;
  List<MessageConversation> _privateMessages = [];
  List<MessageConversation> _validationMessages = [];

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
  List<MessageConversation> get validationMessage => _validationMessages;

  MessageConversation get userReply => _reply;
  MessageConversation get fetchedThread => _fetchedThread;

  Future<void> sendMessages(String id, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations/$id?internal=false'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      },
      body: json.encode(message),
    );

    print(response);

    notifyListeners();
  }

  Future<void> AddNewMessage(String attachment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(
        {
          "subject": "asdfasdfasdfasdf",
          "users": [
            {
              "id": "GOLswS44mh8",
              "username": "system",
              "firstName": "Tom",
              "surname": "Wakiki",
              "displayName": "Tom Wakiki",
              "type": "user"
            },
            {
              "id": "Onf73mPD6sL",
              "username": "keita",
              "firstName": "Seydou",
              "surname": "Keita",
              "displayName": "Seydou Keita",
              "type": "user"
            }
          ],
          "userGroups": [],
          "organisationUnits": [],
          "text": "sdfasdfasdf",
          "attachments": [
            // {"name": attachment, "contentLength": 153509, "loading": true},
          ],
        },
      ),
    );
    notifyListeners();
  }

  Future<void> addParticipant() async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversation/id/recepients'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        "users": [
          {
            "id": "Onf73mPD6sL",
            "username": "keita",
            "firstName": "Seydou",
            "surname": "Keita",
            "displayName": "Seydou Keita",
            "type": "user"
          }
        ],
        "userGroups": [],
        "organisationUnits": [],
      }),
    );

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
    print(response.statusCode);

    if (response.statusCode == 200) {
      final list =
          json.decode(response.body)['messageConversations'] as List<dynamic>;
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

  Future<void> get fetchValidationMessages async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/messageConversations?filter=messageType%3Aeq%3AVALIDATION_RESULT&pageSize=35&page=1&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final list =
          json.decode(response.body)['messageConversations'] as List<dynamic>;
      _map = jsonDecode(response.body) as Map<String, dynamic>;
      _validationMessages = list
          .map((model) =>
              MessageConversation.fromJson(model as Map<String, dynamic>))
          .toList();
      _error = false;
    } else {
      throw Exception("Failed to Load Data");
    }
    notifyListeners();
  }

  Future<void> fetchMessageThreadsById(String id) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/messageConversations/$id?fields=*,assignee%5Bid%2C%20displayName%5D,messages%5B*%2Csender%5Bid%2CdisplayName%5D,attachments%5Bid%2C%20name%2C%20contentLength%5D%5D,userMessages%5Buser%5Bid%2C%20displayName%5D%5D'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print('outside the statuscode');
    if (response.statusCode == 200) {
      print('inside the statuscode');

      final Map<String, dynamic> body =
          json.decode(response.body) as Map<String, dynamic>;
      _fetchedThread = MessageConversation.fromJson(body);
    } else {
      throw Exception('Failed to Load Data');
    }
    notifyListeners();
  }

  void initialValue() {
    // _allMessageConversation = [];
    // _map = {};
    // _error = false;
    // _errorMessage = '';
    _fetchedThread = MessageConversation(
      messageCount: '0',
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
    );
    notifyListeners();
  }
}
