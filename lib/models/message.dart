import 'access.dart';

import 'sharing.dart';
import 'user.dart';

class Message {
  Message({
    required this.lastUpdated,
    required this.id,
    required this.created,
    required this.name,
    required this.internal,
    required this.displayName,
    required this.externalAccess,
    required this.metaData,
    required this.text,
    required this.sharing,
    required this.favorite,
    required this.access,
    required this.sender,
    required this.favorites,
    required this.attachments,
    required this.translations,
    required this.userGroupAccesses,
    required this.attributeValues,
    required this.userAccesses,
  });

  final String lastUpdated;
  final String id;
  final String created;
  final String name;
  final String internal;
  final String displayName;
  final String externalAccess;
  final String metaData;
  final String text;
  final Sharing? sharing;
  final String favorite;
  final Access access;
  final User? sender;
  final List<dynamic> favorites;
  final List<dynamic> attachments;
  final List<dynamic> translations;
  final List<dynamic> userGroupAccesses;
  final List<dynamic> attributeValues;
  final List<dynamic> userAccesses;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        lastUpdated: json["lastUpdated"].toString(),
        id: json["id"].toString(),
        created: json["created"].toString(),
        name: json["name"].toString(),
        internal: json["internal"].toString(),
        displayName: json["displayName"].toString(),
        externalAccess: json["externalAccess"].toString(),
        metaData: json["metaData"].toString(),
        text: json["text"].toString(),
        sharing: json["sharing"] != null
            ? Sharing.fromJson(json["sharing"] as Map<String, dynamic>)
            : null,
        favorite: json["favorite"].toString(),
        access: Access.fromJson(json["access"] as Map<String, dynamic>),
        sender: json["sender"] != null
            ? User.fromJson(json["sender"] as Map<String, dynamic>)
            : null,
        favorites: List<dynamic>.from(
            json["favorites"].map((x) => x) as Iterable<dynamic>),
        attachments: List<dynamic>.from(
            json["attachments"].map((x) => x) as Iterable<dynamic>),
        translations: List<dynamic>.from(
            json["translations"].map((x) => x) as Iterable<dynamic>),
        userGroupAccesses: List<dynamic>.from(
            json["userGroupAccesses"].map((x) => x) as Iterable<dynamic>),
        attributeValues: List<dynamic>.from(
            json["attributeValues"].map((x) => x) as Iterable<dynamic>),
        userAccesses: List<dynamic>.from(
            json["userAccesses"].map((x) => x) as Iterable<dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "lastUpdated": lastUpdated,
        "id": id,
        "created": created,
        "name": name,
        "internal": internal,
        "displayName": displayName,
        "externalAccess": externalAccess,
        "metaData": metaData,
        "text": text,
        "sharing": sharing!.toJson(),
        "favorite": favorite,
        "access": access.toJson(),
        // "sender": sender.toJson(),
        "favorites": List<dynamic>.from(favorites.map((x) => x)),
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "translations": List<dynamic>.from(translations.map((x) => x)),
        "userGroupAccesses":
            List<dynamic>.from(userGroupAccesses.map((x) => x)),
        "attributeValues": List<dynamic>.from(attributeValues.map((x) => x)),
        "userAccesses": List<dynamic>.from(userAccesses.map((x) => x)),
      };
}
