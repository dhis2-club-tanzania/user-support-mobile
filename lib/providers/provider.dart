import 'dart:convert';
import 'dart:developer';

import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/data/data_store/queries/data_store.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import '../constants/d2-repository.dart';

import '/constants/constants.dart';
import '/models/message_conversation.dart';
import '/models/user.dart';
import '../models/approve_model.dart';

class MessageModel with ChangeNotifier {
  final List<MessageConversation> _allMessageConversation = [];
  late List<User> _listOfUsers;
  late MessageConversation _fetchedThread;
  List<MessageConversation> _privateMessages = [];
  List<ApproveModel> _dataApproval = [];
  List<MessageConversation> _validationMessages = [];
  List<MessageConversation> _ticketMessage = [];
  List<MessageConversation> _systemMessages = [];
  late MessageConversation _reply;
  Map<String, dynamic> _map = {};
  bool _error = false;
  final String _errorMessage = '';
  bool _isLoading = false;

  Map<String, dynamic> get map => _map;
  bool get error => _error;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<MessageConversation> get allMessageConversation =>
      _allMessageConversation;
  List<MessageConversation> get ticketMessage => _ticketMessage;
  List<ApproveModel> get dataApproval => _dataApproval;
  List<MessageConversation> get systemMessage => _systemMessages;
  List<User> get listOfUsers => _listOfUsers;
  List<MessageConversation> get privateMessages => _privateMessages;
  List<MessageConversation> get validationMessage => _validationMessages;
  MessageConversation get userReply => _reply;
  MessageConversation get fetchedThread => _fetchedThread;

  // new codes

  Future<void> get fetchDataApproval async {
    try {
      var response = [];
      var res2;

      final res =
          await d2repository.httpClient.get('dataStore/dhis2-user-support');
      DataStoreQuery test = d2repository.dataStore.dataStoreQuery
          .byNamespace('dhis2-user-support');
      log(test.namespace.toString());
      // log(res.toString());
      log(test.toString());
      var list = res.body;

      for (var i = 1; i < list.length; i++) {
        print('dataStore/dhis2-user-support/${list[i]}');

        if (list[i].toString() != "configurations") {
          res2 = await HttpClient.get(
              'dataStore/dhis2-user-support/${list[i].toString()}');
          response.add(res2.body);
        }
      }
      _dataApproval = response
          .map((x) => ApproveModel.fromMap(x as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("error : $e");
    }

    notifyListeners();
  }

  Future<void> approvalRequest(ApproveModel dataApproval,
      {String? message}) async {
    var user = await d2repository.userModule.user.getOne();
    print(user!.username);
    _isLoading = true;
    var id = dataApproval.id!.substring(0, 15);
    Dio dio = Dio();

    String createBasicAuthToken(username, password) {
      return 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    }

    print(id);
    final res = await HttpClient.get(
        'messageConversations?messageType=TICKET&filter=subject:ilike:${id}');

    var convId = res.body['messageConversations'][0]['id'].toString();

    if (message == null) {
      print('This is inside if statement');
      final response = await Future.wait([
        HttpClient.post(dataApproval.url!, dataApproval.payload!.toMap()),
        http.delete(
            Uri.parse(
                "https://tland.dhis2.udsm.ac.tz/api/dataStore/dhis2-user-support/${dataApproval.id}"),
            headers: <String, String>{
              'Authorization':
                  createBasicAuthToken(user.username, user.password)
            }),
        HttpClient.post('messageConversations/${convId}',
            'Ombi lako limeshughulikiwa karibu!'),
        HttpClient.post(
            'messageConversations/${convId}/status?messageConversationStatus=SOLVED',
            ''),
      ]).whenComplete(() => _isLoading = false);
    } else {
      print('This is inside else');

      final response = await Future.wait([
        http.delete(
            Uri.parse(
                "https://tland.dhis2.udsm.ac.tz/api/dataStore/dhis2-user-support/${dataApproval.id}"),
            headers: <String, String>{
              'Authorization':
                  createBasicAuthToken(user.username, user.password)
            }),
        HttpClient.post('messageConversations/${convId}', message),
        HttpClient.post(
            'messageConversations/${convId}/status?messageConversationStatus=SOLVED',
            '')
      ]).whenComplete(() => _isLoading = false);
      inspect(response.first);
      inspect(response[1]);
      inspect(response[2].toString());
    }

    // inspect(res[0].body);
    // inspect(response.first);
    // inspect(response[1].body);

    // final res2 =
    // print("This is a post request : ${res.statusCode}");
    // print("This is a deletion request : ${res2.statusCode}");
    notifyListeners();
  }

  //send message to the message conversation
  Future<void> sendMessages(String id, String message) async {
    if (message.isNotEmpty) {
      _isLoading = true;
    }
    final response = await http.post(
      Uri.parse('$baseUrl/messageConversations/$id?internal=false'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      },
      body: message,
    );

    if (response.statusCode == 200) {
      _isLoading = false;
    } else {
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> addFeedbackMessage(String subject, String text) async {
    _isLoading = true;
    final response = await http.post(
        Uri.parse('$baseUrl/messageConversations/feedback?subject=$subject'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: text);
    print(response.statusCode);
    if (response.statusCode == 201) {
      _isLoading = false;
      print('is Successfully');
    } else {
      _isLoading = false;
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
    _isLoading = true;
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
    print(response.statusCode);
    if (response.statusCode == 200) {
      _isLoading = false;
    } else {
      _isLoading = false;
    }
    notifyListeners();
  }

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
    try {
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
    } catch (e) {
      print("error $e catched");
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

// Future<void> queryUser(String query) async {
//   final url =
//       "$baseUrl/userGroups?fields=id%2C%20displayName&pageSize=10&filter=displayName%3Atoken%3A$query";
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//   );
//   print(response.body);
// }

// Future<void> queryOrgarnizationUnits(String query) async {
//   final url =
//       "$baseUrl/organisationUnits?fields=id,displayName&pageSize=10&filter=displayName%3Atoken%3A$query&filter=users%3Agte%3A1";
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//   );

// if (response.statusCode==200) {

// } else {
// }
// }

// Future<void> queryUserGroups(String query) async {
//   final url =
//       "$baseUrl/userGroups?fields=id%2C%20displayName&pageSize=10&filter=displayName%3Atoken%3A$query";
//   final response = await http.get(
//     Uri.parse(url),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//   );
// }

//add participant
// Future<void> addParticipant() async {
//   final response = await http.post(
//     Uri.parse('$baseUrl/messageConversation/id/recepients'),
//     headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     },
//     body: json.encode({
//       "users": [
//         {
//           "id": "Onf73mPD6sL",
//           "username": "keita",
//           "firstName": "Seydou",
//           "surname": "Keita",
//           "displayName": "Seydou Keita",
//           "type": "user"
//         }
//       ],
//       "userGroups": [],
//       "organisationUnits": [],
//     }),
//   );

//   notifyListeners();
// }

//fetch system message
