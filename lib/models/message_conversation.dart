import 'package:user_support_mobile/models/user_messages.dart';

import 'access.dart';
import 'message.dart';
import 'sharing.dart';
import 'user.dart';

class MessageConversation {
  MessageConversation({
    this.href,
    required this.messageCount,
    required this.followUp,
    required this.lastUpdated,
    required this.id,
    required this.read,
    // required this.created,
    required this.name,
    required this.subject,
    required this.displayName,
    // required this.externalAccess,
    required this.messageType,
    required this.lastMessage,
    // required this.sharing,
    // required this.priority,
    required this.favorite,
    // required this.status,
    // required this.access,
    required this.lastSender,
    this.createdBy,
    // required this.user,
    // required this.favorites,
    // required this.translations,
    required this.userMessages,
    // required this.userGroupAccesses,
    // required this.attributeValues,
    // required this.userAccesses,
    this.messages,
  });

  final String? href;
  final String messageCount;
  final bool followUp;
  final String lastUpdated;
  final String id;
  final bool read;
  // final String created;
  final String name;
  final String subject;
  final String displayName;
  // final bool externalAccess;
  final String messageType;
  final String lastMessage;
  // final Sharing sharing;
  // final String priority;
  final bool favorite;
  // final String status;
  // final Access access;
  final User? lastSender;
  final User? createdBy;
  // final User user;
  // final List<dynamic> favorites;
  // final List<dynamic> translations;
  final List<UserMessages>? userMessages;
  // final List<dynamic> userGroupAccesses;
  // final List<dynamic> attributeValues;
  // final List<dynamic> userAccesses;
  final List<Message>? messages;
  factory MessageConversation.fromJson(Map<String, dynamic> json) {
   
    return MessageConversation(
      href: json['href'].toString(),
      messageCount: json["messageCount"].toString(),
      followUp: json["followUp"] as bool,
      lastUpdated: json["lastUpdated"] as String,
      id: json["id"].toString(),
      read: json["read"] as bool,
      // created: json["created"] as String,
      name: json["name"].toString(),
      subject: json["subject"].toString(),
      displayName: json["displayName"].toString(),
      // externalAccess: json["externalAccess"] as bool,
      messageType: json["messageType"].toString(),
      lastMessage: json["lastMessage"] as String,
      // sharing: Sharing.fromJson(json["sharing"]as Map<String,dynamic>),
      // priority: json["priority"].toString(),
      favorite: json['favorite'] == null ? false : json["favorite"] as bool,
      // status: json["status"].toString(),
      // access: Access.fromJson(json["access"]as Map<String,dynamic>),
      lastSender: User.fromJson(json["lastSender"] as Map<String, dynamic>),
      createdBy: json['createdBy'] != null
          ? User.fromJson(json['createdBy'] as Map<String, dynamic>)
          : null,
      // user: User.fromJson(json["user"] as Map<String,dynamic>),
      // favorites: List<dynamic>.from(json["favorites"].map((x) => x)as Iterable<dynamic>),
      // translations: List<dynamic>.from(json["translations"].map((x) => x)as Iterable<dynamic>),
      userMessages: json['userMessages'] != null
          ? List<UserMessages>.from(json["userMessages"]
                  .map((x) => UserMessages.fromJson(x as Map<String, dynamic>))
              as Iterable)
          : null,

      // userGroupAccesses: List<dynamic>.from(json["userGroupAccesses"].map((x) => x)as Iterable<dynamic>),
      // attributeValues: List<dynamic>.from(json["attributeValues"].map((x) => x)as Iterable<dynamic>),
      // userAccesses: List<dynamic>.from(json["userAccesses"].map((x) => x)as Iterable<dynamic>),
      messages: json["messages"] != null
          ? List<Message>.from(json["messages"]
                  .map((x) => Message.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        // "messageCount": messageCount,
        "followUp": followUp,
        "lastUpdated": lastUpdated,
        "id": id,
        "read": read,
        // "created": created,
        "name": name,
        "subject": subject,
        "displayName": displayName,
        // "externalAccess": externalAccess,
        "messageType": messageType,
        "lastMessage": lastMessage,
        // "sharing": sharing.toJson(),
        // "priority": priority,
        "favorite": favorite,
        // "status": status,
        // "access": access.toJson(),
        // "lastSender": lastSender.toJson(),
        "createdBy": createdBy!.toJson(),
        // "user": user.toJson(),
        // "favorites": List<dynamic>.from(favorites.map((x) => x)),
        // "translations": List<dynamic>.from(translations.map((x) => x)),
        "userMessages":
            List<dynamic>.from(userMessages!.map((x) => x.toJson())),
        // "userGroupAccesses": List<dynamic>.from(userGroupAccesses.map((x) => x)),
        // "attributeValues": List<dynamic>.from(attributeValues.map((x) => x) as Iterable),
        // "userAccesses": List<dynamic>.from(userAccesses.map((x) => x) as Iterable),
        "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}
