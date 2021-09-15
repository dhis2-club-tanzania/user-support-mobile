import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/constants/constants.dart';
import '/models/message_conversation.dart';
import '/models/user.dart';

class MessageModel with ChangeNotifier {
  final List<MessageConversation> _allMessageConversation = [];
  late List<User> _listOfUsers;
  late MessageConversation _fetchedThread;
  List<MessageConversation> _privateMessages = [];
  List<MessageConversation> _validationMessages = [];
  List<MessageConversation> _ticketMessage = [];
  List<MessageConversation> _systemMessages = [];
  late MessageConversation _reply;
  Map<String, dynamic> _map = {};
  bool _error = false;
  final String _errorMessage = '';

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;
  List<MessageConversation> get allMessageConversation =>
      _allMessageConversation;
  List<MessageConversation> get ticketMessage => _ticketMessage;
  List<MessageConversation> get systemMessage => _systemMessages;
  List<User> get listOfUsers => _listOfUsers;
  List<MessageConversation> get privateMessages => _privateMessages;
  List<MessageConversation> get validationMessage => _validationMessages;
  MessageConversation get userReply => _reply;
  MessageConversation get fetchedThread => _fetchedThread;

  //send message to the message conversation
  Future<void> sendMessages(String id, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations/$id?internal=false'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      },
      body: message,
    );
    print("Print the status code");
    print(response.body);
    if (response.statusCode == 201) {
      print('This message was successful sent');
    }
    notifyListeners();
  }

  uploadImageWithHttp(File imageFile, int serialno) async {
    final postBody =
        imageFile != null ? base64Encode(imageFile.readAsBytesSync()) : '';

    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations/internal=false'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(postBody),
    );
    final responseJson = json.decode(response.body);
    print(responseJson);
  }

  Future<void> addFeedbackMessage(String subject, String text) async {
    final response = await http.post(
        Uri.parse('$baseUrl/messageConversations/feedback?subject=$subject'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: text);
    print(response.body);
    if (response.statusCode == 200) {
      print('is Successfully');
    }
    notifyListeners();
  }

  //post message read
  Future<void> messageRead(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations/read'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode([id]),
    );
    print(response.body);
    if (response.statusCode == 200) {
      print('is Successfully');
    }
    notifyListeners();
  }

  //post message unread
  Future<void> messageUnread(String id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations/unread'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode([id]),
    );
    // print(response.body);
    // if (response.statusCode == 200) {
    // }
    notifyListeners();
  }

  //delete message conversation
  Future<void> deleteMessage(String messageId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/messageConversations/$messageId/xE7jOejl9FI'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    print(messageId);
    print(response.statusCode);
    print('$baseUrl/messageConversations/$messageId/xE7jOejl9FI');

    if (response.statusCode == 200) {
      print('is Successfully');
      _privateMessages.removeWhere((messages) => messages.id == messageId);
    }
    notifyListeners();
  }

  //add new message conversation
  Future<void> addNewMessage(
      String attachment, String text, String subject) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(
        {
          "subject": subject,
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
          "text": text,
          "attachments": [
            // {"name": attachment, "contentLength": 153509, "loading": true},
          ],
        },
      ),
    );
    // print(response.body);
    // if (response.statusCode == 200) {
    //   fetchPrivateMessages;
    // }
    notifyListeners();
  }

  Future<void> queryUser(String query) async {
    final url =
        "$baseUrl/userGroups?fields=id%2C%20displayName&pageSize=10&filter=displayName%3Atoken%3A$query";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    print(response.body);
  }

  Future<void> queryOrgarnizationUnits(String query) async {
    final url =
        "$baseUrl/organisationUnits?fields=id,displayName&pageSize=10&filter=displayName%3Atoken%3A$query&filter=users%3Agte%3A1";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // if (response.statusCode==200) {

    // } else {
    // }
  }

  Future<void> queryUserGroups(String query) async {
    final url =
        "$baseUrl/userGroups?fields=id%2C%20displayName&pageSize=10&filter=displayName%3Atoken%3A$query";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  //add participant
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

  //fetch system message
  Future<void> get fetchSystemMessage async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/messageConversations?filter=messageType%3Aeq%3ASYSTEM&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final list =
          json.decode(response.body)['messageConversations'] as List<dynamic>;
      _map = jsonDecode(response.body) as Map<String, dynamic>;
      _systemMessages = list
          .map((model) =>
              MessageConversation.fromJson(model as Map<String, dynamic>))
          .toList();
      _error = false;
    } else {
      throw Exception("Failed to Load Data");
    }
    notifyListeners();
  }

  //fetch private message conversation
  Future<void> get fetchPrivateMessages async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/messageConversations?filter=messageType%3Aeq%3APRIVATE&pageSize=35&page=1&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
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
    } catch (e) {
      print('What error is $e');
    }

    notifyListeners();
  }

  Future<void> get fetchTicketMessages async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/messageConversations?filter=messageType%3Aeq%3ATICKET&pageSize=35&page=1&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final list =
          json.decode(response.body)['messageConversations'] as List<dynamic>;
      _map = jsonDecode(response.body) as Map<String, dynamic>;
      _ticketMessage = list
          .map((model) =>
              MessageConversation.fromJson(model as Map<String, dynamic>))
          .toList();
      _error = false;
    } else {
      throw Exception("Failed to Load Data");
    }
    notifyListeners();
  }

  // fetch validation message
  Future<void> get fetchValidationMessages async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/messageConversations?filter=messageType%3Aeq%3AVALIDATION_RESULT&fields=id,displayName,subject,messageType,lastSender%5Bid%2C%20displayName%5D,assignee%5Bid%2C%20displayName%5D,status,priority,lastUpdated,read,lastMessage,followUp&order=lastMessage%3Adesc'),
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
    } catch (e) {
      print("error $e catched");
    }

    notifyListeners();
  }

  //fetch message conversation by id
  Future<void> fetchMessageThreadsById(String id) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/messageConversations/$id?fields=*,assignee%5Bid%2C%20displayName%5D,messages%5B*%2Csender%5Bid%2CdisplayName%5D,attachments%5Bid%2C%20name%2C%20contentLength%5D%5D,userMessages%5Buser%5Bid%2C%20displayName%5D%5D'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body =
          json.decode(response.body) as Map<String, dynamic>;
      _fetchedThread = MessageConversation.fromJson(body);
    }
    notifyListeners();
    //delete message conversation
  }

  void initialValue() {
    // _allMessageConversation = [];
    // _map = {};
    // _error = false;
    // _errorMessage = '';
    _fetchedThread = MessageConversation(
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
      createdBy: User(displayName: '', name: '', id: '', username: ''),
    );
    notifyListeners();
  }
}
