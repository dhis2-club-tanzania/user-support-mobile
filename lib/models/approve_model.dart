// To parse this JSON data, do
//
//      approveModel = approveModelFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:user_support_mobile/controller/controllers.dart';
import 'package:user_support_mobile/models/user_approval.dart';


ApproveModel approveModelFromMap(String str) =>
    ApproveModel.fromMap(json.decode(str));

String approveModelToMap(ApproveModel data) => json.encode(data.toMap());

class ApproveModel {
  ApproveModel({
    this.id,
    this.url,
    this.user,
    this.action,
    this.method,
    this.status,
    this.message,
    this.payload,
    this.actionType,
    this.shouldAlert,
    this.replyMessage,
    this.ticketNumber,
    this.messageConversation,
    this.timeSinceResponseSent,
    this.rejectionReasonMessage,
  });

  String? id;
  String? url;
  String? action;
  String? method;
  String? status;
  String? actionType;
  String? ticketNumber;
  String? replyMessage;
  UserModel2? user;
  Message? message;
  Payload? payload;
  bool? shouldAlert;
  MessageConv? messageConversation;
  String? timeSinceResponseSent;
  String? rejectionReasonMessage;

  factory ApproveModel.fromMap(Map<String, dynamic> json) => ApproveModel(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
    user: json["user"] == null ? null : UserModel2.fromMap(json["user"]),
    action: json["action"] == null ? null : json["action"],
    method: json["method"] == null ? null : json["method"],
    status: json["status"] == null ? null : json["status"],
    message:
    json["message"] == null ? null : Message.fromMap(json["message"]),
    payload:
    json["payload"] == null ? null : Payload.fromMap(json["payload"]),
    actionType: json["actionType"] == null ? null : json["actionType"],
    shouldAlert: json["shouldAlert"] == null ? null : json["shouldAlert"],
    replyMessage:
    json["replyMessage"] == null ? null : json["replyMessage"],
    ticketNumber:
    json["ticketNumber"] == null ? null : json["ticketNumber"],
    messageConversation: json["messageConversation"] == null
        ? null
        : MessageConv.fromMap(json["messageConversation"]),
    timeSinceResponseSent: json["timeSinceResponseSent"] == null
        ? null
        : json["timeSinceResponseSent"],
    rejectionReasonMessage: json["rejectionReasonMessage"] == null
        ? null
        : json["rejectionReasonMessage"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "user": user == null ? null : user!.toMap(),
    "action": action == null ? null : action,
    "method": method == null ? null : method,
    "status": status == null ? null : status,
    "message": message == null ? null : message!.toMap(),
    "payload": payload == null ? null : payload!.toMap(),
    "actionType": actionType == null ? null : actionType,
    "shouldAlert": shouldAlert == null ? null : shouldAlert,
    "replyMessage": replyMessage == null ? null : replyMessage,
    "ticketNumber": ticketNumber == null ? null : ticketNumber,
    "messageConversation":
    messageConversation == null ? null : messageConversation!.toMap(),
    "timeSinceResponseSent":
    timeSinceResponseSent == null ? null : timeSinceResponseSent,
    "rejectionReasonMessage":
    rejectionReasonMessage == null ? null : rejectionReasonMessage,
  };
}

class Message {
  Message({
    this.message,
    this.subject,
    this.messageContentsLength,
  });

  String? message;
  String? subject;
  int? messageContentsLength;

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    message: json["message"] == null ? null : json["message"],
    subject: json["subject"] == null ? null : json["subject"],
    messageContentsLength: json["messageContentsLength"] == null
        ? null
        : json["messageContentsLength"],
  );

  Map<String, dynamic> toMap() => {
    "message": message == null ? null : message,
    "subject": subject == null ? null : subject,
    "messageContentsLength":
    messageContentsLength == null ? null : messageContentsLength,
  };
}

class MessageConv {
  MessageConv({
    this.id,
    this.displayName,
  });

  String? id;
  String? displayName;

  factory MessageConv.fromMap(Map<String, dynamic> json) => MessageConv(
    id: json["id"] == null ? null : json["id"],
    displayName: json["displayName"] == null ? null : json["displayName"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "displayName": displayName == null ? null : displayName,
  };
}

class Payload {
  Payload({
    this.additions,
    this.deletions,
  });

  List<Addition>? additions;
  List<Addition>? deletions;

  factory Payload.fromMap(Map<String, dynamic> json) => Payload(
    additions: json["additions"] == null
        ? null
        : List<Addition>.from(
        json["additions"].map((x) => Addition.fromMap(x))),
    deletions: json["deletions"] == null
        ? null
        : List<Addition>.from(
        json["deletions"].map((x) => Addition.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "additions": additions == null
        ? null
        : List<dynamic>.from(additions!.map((x) => x.toMap())),
    "deletions": deletions == null
        ? null
        : List<dynamic>.from(deletions!.map((x) => x.toMap())),
  };
}

class Addition {
  Addition({
    this.id,
    this.level,
    this.name,
  });

  String? id;
  String? name;
  int? level;

  factory Addition.fromMap(Map<String, dynamic> json) => Addition(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    level: json["level"] == null ? null : json["level"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "level": level == null ? null : level,
  };
}

class UserModel2 {
  UserModel2({
    this.id,
    this.email,
    this.jobTitle,
    this.userName,
    this.displayName,
    this.phoneNumber,
    this.organisationUnits,


  });

  String? id;
  String? email;
  String? jobTitle;
  String? userName;
  String? displayName;
  String? phoneNumber;


  List<Addition>? organisationUnits;

  factory UserModel2.fromMap(Map<String, dynamic> json) => UserModel2(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
    userName: json["userName"] == null ? null : json["userName"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    organisationUnits: json["organisationUnits"] == null
        ? null
        : List<Addition>.from(
        json["organisationUnits"].map((x) => Addition.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "jobTitle": jobTitle == null ? null : jobTitle,
    "userName": userName == null ? null : userName,
    "displayName": displayName == null ? null : displayName,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "organisationUnits": organisationUnits == null
        ? null
        : List<dynamic>.from(organisationUnits!.map((x) => x.toMap())),
  };
}

class UserModel {
  UserModel({
    this.id,
    this.action,
    this.user,
    this.userPayload,

    this.method,
    this.replyMessage,
    this.ticketNumber,
    this.type,
    this.url,
    this.message,
    this.status,
    this.messageBody,
    this.actionType,
    this.rejectionReasonMessage,
    this.timeSinceResponseSent,
    this.messageConversation,
    this.shouldAlert,
    this.privateMessage,
    this.rowColor,
  });

  String? id;
  UserModel3? user;
  List<Userpayload>? userPayload;

  Color? rowColor;
  String? ticketNumber;
  String? type;
  String? status;
  String? url;
  String? method;
  String? action;
  String? actionType;
  String? replyMessage;
  String? timeSinceResponseSent;
  String? rejectionReasonMessage;
  MessageConv? messageConversation;
  PrivateMessage? privateMessage;
  Message? message;
  bool? shouldAlert;
  MessageBody?  messageBody;


  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    user: json["user"] == null ? null : UserModel3.fromMap(json["user"]),
    method: json["method"] == null ? null : json["method"],
    //payload: json["payload"] == null ? null : List<PayloadUser>.from(json["payload"].map((x) => PayloadUser.fromMap(x))),
    userPayload: json["payload"] != null
        ? (json["payload"] is List
        ? (json["payload"] as List<dynamic>)
        .map((e) => Userpayload.fromMap(e as Map<String, dynamic>))
        .toList()
        : [Userpayload.fromMap(json["payload"] as Map<String, dynamic>)])
        : [],
    url: json["url"] == null ? null : json["url"],
    timeSinceResponseSent: json["timeSinceResponseSent"] == null
        ? null
        : json["timeSinceResponseSent"],
    messageConversation: json["messageConversation"] == null
        ? null
        : MessageConv.fromMap(json["messageConversation"]),
    privateMessage: json["privateMessage"] == null
        ? null
        : PrivateMessage.fromMap(json["privateMessage"]),
    shouldAlert: json["shouldAlert"] == null ? null : json["shouldAlert"],
    message: json["message"] == null ? null : Message.fromMap(json["message"]),
    type: json["type"] == null ? null : json["type"],
    action: json["action"] == null ? null : json["action"],
    actionType: json["actionType"] == null ? null : json["actionType"],
    rejectionReasonMessage: json["rejectionReasonMessage"] == null ? null : json["rejectionReasonMessage"],
    replyMessage: json["replyMessage"] == null ? null : json["replyMessage"],
    ticketNumber: json["ticketNumber"] == null ? null : json["ticketNumber"],
    messageBody: json["messageBody"] == null ? null : MessageBody.fromMap(json["messageBody"]),
    rowColor: Colors.transparent,
  );



  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "status": status == null ? null : status,
    "method": method == null ? null : method,
    "shouldAlert": shouldAlert == null ? null : shouldAlert,
    "action": action == null ? null : action,
    "actionType": actionType == null ? null : actionType,
    "userName": type == null ? null : type,
    "timeSinceResponseSent":
    timeSinceResponseSent == null ? null : timeSinceResponseSent,
    "message": message == null ? null : message!.toMap(),
    "user": user == null ? null : user!.toMap(),
    "payload": userPayload == null
        ? null
        : List<dynamic>.from(userPayload!.map((x) => x.toMap()).toList()),

    "messageConversation":
    messageConversation == null ? null : messageConversation!.toMap(),
    "privateMessage":
    privateMessage == null ? null : privateMessage!.toMap(),
    "replyMessage": replyMessage == null ? null : replyMessage,
    "rejectionReasonMessage": rejectionReasonMessage == null ? null : rejectionReasonMessage,
    "ticketNumber": ticketNumber == null ? null : ticketNumber,
    "messageBody": messageBody == null ? null : messageBody!.toMap(),
  };


}

class PrivateMessage {
  PrivateMessage({
    this.subject,
    this.text,
    this.users,
  });

  String? subject;
  String? text;
  List<Users>? users;

  factory PrivateMessage.fromMap(Map<String, dynamic> json) => PrivateMessage(
    subject: json["subject"] == null ? null : json["subject"],
    text: json["text"] == null ? null : json["text"],
    users: json["users"] == null ? null : List<Users>.from(json["users"].map((x) => Users.fromMap(x))),
  );

  Map<String, dynamic> toMap() =>
      {
        "text": text == null ? null : text,
        "subject": subject == null ? null : subject,
        "users": users == null ? null : List<dynamic>.from(users!.map((x) => x.toMap())),
      };
}

class MessageBody {
  MessageBody({
    this.attachments,
    this.organisationUnits,
    this.subject,
    this.text,
    this.userGroups,
    this.users,
  });

  List<String>? attachments;
  List<String>? organisationUnits;
  String? subject;
  String? text;
  List<String>? userGroups;
  List<Users>? users;

  factory MessageBody.fromMap(Map<String, dynamic> json) => MessageBody(
    subject: json["subject"] == null ? null : json["subject"],
    text: json["text"] == null ? null : json["text"],
    attachments: json["attachments"] == null
        ? null
        : List<String>.from(json["attachments"].map((x) => x.toString())),
    organisationUnits: json["organisationUnits"] == null
        ? null
        : List<String>.from(json["organisationUnits"].map((x) => x.toString())),
    userGroups: json["userGroups"] == null
        ? null
        : List<String>.from(json["userGroups"].map((x) => x.toString())),
    users: json["users"] == null ? null : List<Users>.from(json["users"].map((x) => Users.fromMap(x))),
  );

  Map<String, dynamic> toMap() =>
      {
        "text": text == null ? null : text,
        "subject": subject == null ? null : subject,
        "attachments": attachments == null ? null : List<dynamic>.from(attachments!),
        "organisationUnits": organisationUnits == null ? null : List<dynamic>.from(organisationUnits!),
        "userGroups": userGroups == null ? null : List<dynamic>.from(userGroups!),
        "users": users == null ? null : List<dynamic>.from(users!.map((x) => x.toMap())),
      };

}

class UserModel3 {
  UserModel3({
    this.id,
    this.email,
    this.jobTitle,
    this.username,
    this.displayName,
    this.phoneNumber,
    this.birthday,
    this.created,
    this.education,
    this.employer,
    this.externalAccess,
    this.firstName,
    this.gender,
    this.interests,
    this.introductions,
    this.languages,
    this.name,
    this.nationality,
    this.surname,
    this.lastUpdated,
    this.authorities,
    this.favorites,
    this.dataSets,
    this.dataViewOrganisationUnits,
    this.programs,
    this.teiSearchOrganisationUnits,
    this.translations,
    this.userAccesses,
    this.userGroupAccesses,
    this.userGroups,
    this.keyedAuthorities,
    this.settings,
    this.sharing,
    this.access,
    this.userCredentials,
    this.userGroupsKeyed,
    this.userRoles,
    this.organisationUnits,
  });

  String? id;
  String? email;
  String? jobTitle;
  String? username;
  String? displayName;
  String? phoneNumber;
  String? birthday;
  String? created;
  String? education;
  String? employer;
  bool? externalAccess;
  String? firstName;
  String? gender;
  String? interests;
  String? introductions;
  String? languages;
  String? name;
  String? nationality;
  String? surname;
  String? lastUpdated;
  List<String>? authorities;
  List<String>? favorites;
  List<String>? dataSets;
  List<String>? dataViewOrganisationUnits;
  List<String>? programs;
  List<String>? teiSearchOrganisationUnits;
  List<String>? translations;
  List<String>? userAccesses;
  List<String>? userGroupAccesses;
  List<UserGroups>? userGroups;
  KeyedAuthorities? keyedAuthorities;
  Settings? settings;
  Sharing? sharing;
  Access? access;
  UserCredentials? userCredentials;
  UserGroupsKeyed? userGroupsKeyed;
  List<UserRoles>? userRoles;
  List<Addition>? organisationUnits;

  factory UserModel3.fromMap(Map<String, dynamic> json) => UserModel3(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
    username: json["username"] == null ? null : json["username"],
    displayName: json["displayName"] == null ? null : json["displayName"],
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    created: json["created"] == null ? null : json["created"],
    education: json["education"] == null ? null : json["education"],
    employer: json["employer"] == null ? null : json["employer"],
    externalAccess: json["externalAccess"] == null ? null : json["externalAccess"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    gender: json["gender"] == null ? null : json["gender"],
    interests: json["interests"] == null ? null : json["interests"],
    introductions: json["introductions"] == null ? null : json["introductions"],
    languages: json["languages"] == null ? null : json["languages"],
    name: json["name"] == null ? null : json["name"],
    nationality: json["nationality"] == null ? null : json["nationality"],
    surname: json["surname"] == null ? null : json["surname"],
    lastUpdated: json["lastUpdated"] == null ? null : json["lastUpdated"],
    authorities: json["authorities"] == null
        ? null
        : List<String>.from(json["authorities"].map((x) => x.toString())),

    favorites: json["favorites"] == null
        ? null
        : List<String>.from(json["favorites"].map((x) => x.toString())),

    dataSets: json["dataSets"] == null
        ? null
        : List<String>.from(json["dataSets"].map((x) => x.toString())),

    dataViewOrganisationUnits: json["dataViewOrganisationUnits"] == null
        ? null
        : List<String>.from(json["dataViewOrganisationUnits"].map((x) => x.toString())),

    programs: json["programs"] == null
        ? null
        : List<String>.from(json["programs"].map((x) => x.toString())),

    teiSearchOrganisationUnits: json["teiSearchOrganisationUnits"] == null ? null : List<String>.from(json["teiSearchOrganisationUnits"].map((x) => x.toString())),
    translations: json["translations"] == null ? null : List<String>.from(json["translations"].map((x) => x.toString())),
    userAccesses: json["userAccesses"] == null ? null : List<String>.from(json["userAccesses"].map((x) => x.toString())),
    userGroupAccesses: json["userGroupAccesses"] == null ? null : List<String>.from(json["userGroupAccesses"].map((x) => x.toString())),
    userGroups: json["userGroups"] == null ? null : List<UserGroups>.from(json["userGroups"].map((x) => UserGroups.fromMap(x))),
    keyedAuthorities: json["keyedAuthorities"] == null ? null : KeyedAuthorities.fromMap(json["keyedAuthorities"]),
    settings: json["settings"] == null ? null : Settings.fromMap(json["settings"]),
    sharing: json["sharing"] == null ? null : Sharing.fromMap(json["sharing"]),
    access: json["access"] == null ? null : Access.fromMap(json["access"]),
    userCredentials: json["userCredentials"] == null ? null : UserCredentials.fromMap(json["userCredentials"]),
    userGroupsKeyed: json["userGroupsKeyed"] == null ? null : UserGroupsKeyed.fromMap(json["userGroupsKeyed"]),
    userRoles: json["userRoles"] == null ? null : List<UserRoles>.from(json["userRoles"].map((x) => UserRoles.fromMap(x))),
    organisationUnits: json["organisationUnits"] == null ? null : List<Addition>.from(json["organisationUnits"].map((x) => Addition.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "jobTitle": jobTitle == null ? null : jobTitle,
    "userName": username == null ? null : username,
    "displayName": displayName == null ? null : displayName,
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "birthday": birthday == null ? null : birthday,
    "created": created == null ? null : created,
    "education": education == null ? null : education,
    "employer": employer == null ? null : employer,
    "externalAccess": externalAccess == null ? null : externalAccess,
    "firstName": firstName == null ? null : firstName,
    "gender": gender == null ? null : gender,
    "interests": interests == null ? null : interests,
    "introductions": introductions == null ? null : introductions,
    "languages": languages == null ? null : languages,
    "name": name == null ? null : name,
    "nationality": nationality == null ? null : nationality,
    "surname": surname == null ? null : surname,
    "lastUpdated": lastUpdated == null ? null : lastUpdated,
    "authorities": authorities == null ? null : List<dynamic>.from(authorities!),

    "favorites": favorites == null ? null : List<dynamic>.from(favorites!),

    "dataSets": dataSets == null ? null : List<dynamic>.from(dataSets!),
    "dataViewOrganisationUnits": dataViewOrganisationUnits == null ? null : List<dynamic>.from(dataViewOrganisationUnits!),
    "programs": programs == null ? null : List<dynamic>.from(programs!),
    "teiSearchOrganisationUnits": teiSearchOrganisationUnits == null ? null : List<dynamic>.from(teiSearchOrganisationUnits!),
    "translations": translations == null ? null : List<dynamic>.from(translations!),
    "userAccesses": userAccesses == null ? null : List<dynamic>.from(userAccesses!),
    "userGroupAccesses": userGroupAccesses == null ? null : List<dynamic>.from(userGroupAccesses!),
    "userGroups": userGroups == null ? null : List<dynamic>.from(userGroups!.map((x) => x.toMap())),
    "keyedAuthorities": keyedAuthorities == null ? null : keyedAuthorities!.toMap(),
    "settings": settings == null ? null : settings!.toMap(),
    "sharing": sharing == null ? null : sharing!.toMap(),
    "access": access == null ? null : access!.toMap(),
    "userCredentials": userCredentials == null ? null : userCredentials!.toMap(),
    "userGroupsKeyed": userGroupsKeyed == null ? null : userGroupsKeyed!.toMap(),
    "userRoles": userRoles == null ? null : List<dynamic>.from(userRoles!.map((x) => x.toMap())),
    "organisationUnits": organisationUnits == null ? null : List<dynamic>.from(organisationUnits!.map((x) => x.toMap())),
  };
}

// Placeholder classes for the related objects (they need to be fully defined based on your project requirements)
class Access {
  Access({
    this.delete,
    this.externalize,
    this.manage,
    this.read,
    this.update,
    this.write,
  });

  bool? delete;
  bool? externalize;
  bool? manage;
  bool? read;
  bool? update;
  bool? write;

  factory Access.fromMap(Map<String, dynamic> json) => Access(
    delete: json["delete"] == null ? null : json["delete"],
    externalize: json["externalize"] == null ? null : json["externalize"],
    manage: json["manage"] == null ? null : json["manage"],
    read: json["read"] == null ? null : json["read"],
    update: json["update"] == null ? null : json["update"],
    write: json["write"] == null ? null : json["write"],
  );

  Map<String, dynamic> toMap() => {
    "delete": delete == null ? null : delete,
    "externalize": externalize == null ? null : externalize,
    "manage": manage == null ? null : manage,
    "read": read == null ? null : read,
    "update": update == null ? null : update,
    "write": write == null ? null : write,
  };
}

class UserGroup {
  UserGroup({

    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory UserGroup.fromMap(Map<String, dynamic> json) =>
      UserGroup(

        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}


class UserGroups {
  UserGroups({
    this.userGroups,
  });

  List<UserGroup>? userGroups;

  factory UserGroups.fromMap(Map<String, dynamic> json) =>
      UserGroups(
        userGroups: json["userGroups"] == null
            ? null
            : List<UserGroup>.from(json["userGroups"].map((x) => UserGroup.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {
        "userGroups": userGroups == null
            ? null
            : List<dynamic>.from(userGroups!.map((x) => x.toMap())),
      };
}


class Settings {
  Settings({
    this.keyAnalysisDisplayProperty,
    this.keyMessageEmailNotification,
    this.keyMessageSmsNotification,
    this.keyStyle,
    this.keyUiLocale,
  });

  String? keyAnalysisDisplayProperty;
  bool? keyMessageEmailNotification;
  bool? keyMessageSmsNotification;
  String? keyStyle;
  String? keyUiLocale;

  factory Settings.fromMap(Map<String, dynamic> json) =>
      Settings(
        keyAnalysisDisplayProperty: json["keyAnalysisDisplayProperty"] == null ? null : json["keyAnalysisDisplayProperty"],
        keyMessageEmailNotification: json["keyMessageEmailNotification"] == null ? null : json["keyMessageEmailNotification"],
        keyMessageSmsNotification: json["keyMessageSmsNotification"] == null ? null : json["keyMessageSmsNotification"],
        keyStyle: json["keyStyle"] == null ? null : json["keyStyle"],
        keyUiLocale: json["keyUiLocale"] == null ? null : json["keyUiLocale"],
      );

  Map<String, dynamic> toMap() =>
      {
        "keyUiLocale": keyUiLocale == null ? null : keyUiLocale,
        "keyStyle": keyStyle == null ? null : keyStyle,
        "keyMessageSmsNotification": keyMessageSmsNotification == null ? null : keyMessageSmsNotification,
        "keyMessageEmailNotification": keyMessageEmailNotification == null ? null : keyMessageEmailNotification,
        "keyAnalysisDisplayProperty": keyAnalysisDisplayProperty == null ? null : keyAnalysisDisplayProperty,

      };

}

class Sharing {
  Sharing({
    this.external,
    this.userGroups,
    this.users,
  });

  bool? external;
  UserGroups? userGroups;
  Users? users;

  factory Sharing.fromMap(Map<String, dynamic> json) => Sharing(

    external: json["external"] == null ? null : json["external"],
    userGroups: json["userGroups"] == null ? null : UserGroups.fromMap(json["userGroups"]),
    users: json["users"] == null ? null : Users.fromMap(json["users"]),
  );

  Map<String, dynamic> toMap() => {
    "external": external == null ? null : external,
    "userGroups": userGroups == null ? null : userGroups!.toMap(),
    "users": users == null ? null : users!.toMap(),

  };
}

class Users {
  Users({
    this.users,
  });

  Map<String, UsersInnerObject>? users;

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    users: json["users"] == null
        ? null
        : Map.from(json["users"]).map((key, value) => MapEntry(
      key,
      UsersInnerObject.fromMap(value),
    )),
  );

  Map<String, dynamic> toMap() => {
    "users": users == null
        ? null
        : Map.from(users!).map((key, value) => MapEntry(
      key,
      value.toMap(),
    )),
  };
}
class UsersInnerObject {
  UsersInnerObject({
    this.id,
    this.username,
    this.type,
  });

  String? id;
  String? username;
  String? type;

  factory UsersInnerObject.fromMap(Map<String, dynamic> json) => UsersInnerObject(
    id: json["id"] == null ? null : json["id"],
    username: json["username"] == null ? null : json["username"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "name": username == null ? null : username,
        "type": type == null ? null : type,
      };
}


class UserCredentials {
  UserCredentials({
    this.access,
    this.catDimensionConstraints,
    this.cogsDimensionConstraints,
    this.disabled,
    this.externalAuth,
    this.id,
    this.invitation,
    this.lastLogin,
    this.passwordLastUpdated,
    this.previousPasswords,
    this.selfRegistered,
    this.sharing,
    this.twoFA,
    this.userRoles,
    this.username,
    this.password,
  });

  bool? disabled;
  bool? externalAuth;
  bool? selfRegistered;
  bool? twoFA;
  bool? invitation;
  String? username;
  String? id;
  String? password;
  String? lastLogin;
  String? passwordLastUpdated;
  List<String>? previousPasswords;
  List<String>? catDimensionConstraints;
  List<String>? cogsDimensionConstraints;
  Sharing? sharing;
  Access? access;
  List<UserRoles>? userRoles;

  factory UserCredentials.fromMap(Map<String, dynamic> json) =>
      UserCredentials(
        id: json["id"] == null ? null : json["id"],
        lastLogin: json["lastLogin"] == null ? null : json["lastLogin"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        selfRegistered: json["id"] == null ? null : json["selfRegistered"],
        externalAuth: json["externalAuth"] == null ? null : json["externalAuth"],
        disabled: json["disabled"] == null ? null : json["disabled"],
        invitation: json["invitation"] == null ? null : json["invitation"],
        twoFA: json["twoFA"] == null ? null : json["twoFA"],
        passwordLastUpdated: json["passwordLastUpdated"] == null ? null : json["passwordLastUpdated"],
        previousPasswords: json["previousPasswords"] == null ? null : List<String>.from(json["previousPasswords"].map((x) => x.toString())),
        catDimensionConstraints: json["catDimensionConstraints"] == null ? null : List<String>.from(json["catDimensionConstraints"].map((x) => x.toString())),
        cogsDimensionConstraints: json["cogsDimensionConstraints"] == null ? null : List<String>.from(json["cogsDimensionConstraints"].map((x) => x.toString())),
        userRoles: json["userRoles"] == null
            ? null
            : List<UserRoles>.from(json["userRoles"].map((x) => UserRoles.fromMap(x))),

        sharing: json["sharing"] == null ? null : Sharing.fromMap(json["sharing"]),
        access: json["access"] == null ? null : Access.fromMap(json["access"]),

      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "lastLogin": lastLogin == null ? null : lastLogin,
        "invitation": invitation == null ? null : invitation,
        "twoFA": twoFA == null ? null : twoFA,
        "selfRegistered": selfRegistered == null ? null : selfRegistered,
        "externalAuth": externalAuth == null ? null : externalAuth,
        "disabled": disabled == null ? null : disabled,
        "passwordLastUpdated": passwordLastUpdated == null ? null : passwordLastUpdated,
        "previousPasswords": previousPasswords == null ? null : List<dynamic>.from(previousPasswords!),
        "catDimensionConstraints": catDimensionConstraints == null ? null : List<dynamic>.from(catDimensionConstraints!),
        "cogsDimensionConstraints": cogsDimensionConstraints == null ? null : List<dynamic>.from(cogsDimensionConstraints!),
        "userRoles": userRoles == null ? null : List<dynamic>.from(userRoles!.map((x) => x.toMap())),
        "sharing": sharing == null ? null : sharing!.toMap(),
        "access": access == null ? null : access!.toMap(),
      };

}

class UserCredentialsPayload {
  UserCredentialsPayload({
    this.catDimensionConstraints,
    this.cogsDimensionConstraints,
    this.userRoles,
    this.username,
    this.password,
  });

  String? username;
  String? password;
  List<String>? catDimensionConstraints;
  List<String>? cogsDimensionConstraints;
  List<UserRoles>? userRoles;

  factory UserCredentialsPayload.fromMap(Map<String, dynamic> json) =>
      UserCredentialsPayload(
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        catDimensionConstraints: json["catDimensionConstraints"] == null ? null : List<String>.from(json["catDimensionConstraints"].map((x) => x.toString())),
        cogsDimensionConstraints: json["cogsDimensionConstraints"] == null ? null : List<String>.from(json["cogsDimensionConstraints"].map((x) => x.toString())),
        userRoles: json["userRoles"] == null
            ? null
            : List<UserRoles>.from(json["userRoles"].map((x) => UserRoles.fromMap(x))),

      );

  Map<String, dynamic> toMap() =>
      {
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "catDimensionConstraints": catDimensionConstraints == null ? null : List<dynamic>.from(catDimensionConstraints!),
        "cogsDimensionConstraints": cogsDimensionConstraints == null ? null : List<dynamic>.from(cogsDimensionConstraints!),
        "userRoles": userRoles == null ? null : List<dynamic>.from(userRoles!.map((x) => x.toMap())),
      };

}

class UserGroupsKeyed {
  UserGroupsKeyed({
    this.userGroupsKeyed,
  });

  Map<String, InnerObject>? userGroupsKeyed;

  factory UserGroupsKeyed.fromMap(Map<String, dynamic> json) => UserGroupsKeyed(
    userGroupsKeyed: json["userGroupsKeyed"] == null
        ? null
        : Map.from(json["userGroupsKeyed"]).map((key, value) => MapEntry(
      key,
      InnerObject.fromMap(value),
    )),
  );

  Map<String, dynamic> toMap() => {
    "userGroupsKeyed": userGroupsKeyed == null
        ? null
        : Map.from(userGroupsKeyed!).map((key, value) => MapEntry(
      key,
      value.toMap(),
    )),
  };
}
class InnerObject {
  InnerObject({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory InnerObject.fromMap(Map<String, dynamic> json) => InnerObject(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}


class UserRoles {
  UserRoles({

    this.id,
  });

  String? id;

  factory UserRoles.fromMap(Map<String, dynamic> json) =>
      UserRoles(

        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
      };
}

class KeyedAuthorities {
  KeyedAuthorities({
    this.keyedAuthorities,
  });

  Map<String, KeyedAuthority>? keyedAuthorities;

  // Factory constructor for creating a KeyedAuthorities instance from a map.
  factory KeyedAuthorities.fromMap(Map<String, dynamic> json) => KeyedAuthorities(
    keyedAuthorities: json["keyedAuthorities"] == null
        ? null
        : Map.from(json["keyedAuthorities"]).map((key, value) => MapEntry(
      key, KeyedAuthority.fromMap(value),
    )),
  );

  // Method to convert KeyedAuthorities instance to a map.
  Map<String, dynamic> toMap() => {
    "keyedAuthorities": keyedAuthorities == null
        ? null
        : keyedAuthorities!.map((key, value) => MapEntry(
      key, value.toMap(),
    )),
  };
}

class KeyedAuthority {
  KeyedAuthority({
    this.key,
    this.value,
  });

  String? key;
  String? value;

  // Factory constructor for creating a KeyedAuthority instance from a map.
  factory KeyedAuthority.fromMap(Map<String, dynamic> json) => KeyedAuthority(
    key: json["key"],
    value: json["value"],
  );

  // Method to convert KeyedAuthority instance to a map.
  Map<String, dynamic> toMap() => {
    "key": key,
    "value": value,
  };
}


class Userpayload {
  List<Operation>? operations;
  UserCredentialsPayload? userCredentials;
  List<dynamic>? attributeValues;
  List<DataViewOrganisationUnit>? dataViewOrganisationUnits;
  List<OrganisationUnit>? organisationUnits;
  String? phoneNumber;
  String? referenceId;
  String? surname;
  String? username;
  String? firstName;
  String? status;
  List<UserGroup>? userGroups;
  String? email;
  String? password;
  String? reason;

  Userpayload({
    this.attributeValues,
    this.dataViewOrganisationUnits,
    this.organisationUnits,
    this.reason,
    this.phoneNumber,
    this.referenceId,
    this.surname,
    this.userCredentials,
    this.userGroups,
    this.operations,
    this.firstName,
    this.username,
    this.email,
    this.password,
    this.status,
  });

  factory Userpayload.fromMap(Map<String, dynamic> json) {
    return Userpayload(

      attributeValues: json["attributeValues"] != null
          ? List<dynamic>.from(json["attributeValues"])
          : null,
      dataViewOrganisationUnits: json["dataViewOrganisationUnits"] != null
          ? List<DataViewOrganisationUnit>.from(json["dataViewOrganisationUnits"].map((x) => DataViewOrganisationUnit.fromMap(x as Map<String, dynamic>)))
          : null,
      organisationUnits: json["organisationUnits"] != null
          ? List<OrganisationUnit>.from(json["organisationUnits"].map((x) => OrganisationUnit.fromMap(x as Map<String, dynamic>)))
          : null,
      phoneNumber: json["phoneNumber"] as String?,
      referenceId: json["referenceId"] as String?,
      surname: json["surname"] as String?,
      email: json["email"] as String?,
      status: json["status"] as String?,
      username: json["username"] as String?,
      password: json["password"] as String?,
      reason: json["reason"] as String?,
      firstName: json["firstName"] as String?,
      userCredentials: json["userCredentials"] != null
          ? UserCredentialsPayload.fromMap(json["userCredentials"] as Map<String, dynamic>)
          : null,
      userGroups: json["userGroups"] != null
          ? List<UserGroup>.from(json["userGroups"].map((x) => UserGroup.fromMap(x as Map<String, dynamic>)))

          : null,
      operations: json["operations"] != null
          ? List<Operation>.from(json["operations"].map((x) => Operation.fromMap(x as Map<String, dynamic>)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (attributeValues != null) "attributeValues": attributeValues,
      if (dataViewOrganisationUnits != null) "dataViewOrganisationUnits": dataViewOrganisationUnits!.map((x) => x.toMap()).toList(),
      if (organisationUnits != null) "organisationUnits": organisationUnits!.map((x) => x.toMap()).toList(),

      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (referenceId != null) "referenceId": referenceId,
      if (surname != null) "surname": surname,
      if (firstName != null) "firstName": firstName,
      if (username != null) "username": username,
      if (password != null) "password": password,
      if (reason != null) "reason": reason,
      if (email != null) "email": email,
      if (status != null) "status": status,
      if (userCredentials != null) "userCredentials": userCredentials!.toMap(),
      if (userGroups != null) "userGroups": userGroups!.map((x) => x.toMap()).toList(),
      if (operations != null) "operations": operations!.map((x) => x.toMap()).toList(),
    };
  }
}




class OrganisationUnit {
  String? id;
  int? level;
  String? name;
  String? path;
  List<OrganisationUnit>? children;

  OrganisationUnit({
    this.id,
    this.level,
    this.name,
    this.path,

    this.children,
  });

  factory OrganisationUnit.fromMap(Map<String, dynamic> json) => OrganisationUnit(
    id: json["id"],
    level: json["level"],
    name: json["name"],
    path: json["path"],
    children: json["children"] != null
        ? List<OrganisationUnit>.from(json["children"].map((x) => OrganisationUnit.fromMap(x)))
        : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "level": level,
    "name": name,
    "path": path,
    if (children != null) "children": List<dynamic>.from(children!.map((x) => x.toMap())),
  };
}

class DataViewOrganisationUnit {
  String? id;
  int? level;
  String? name;
  String? path;
  List<DataViewOrganisationUnit>? children;

  DataViewOrganisationUnit({
    this.id,
    this.level,
    this.name,
    this.path,
    this.children,
  });

  factory DataViewOrganisationUnit.fromMap(Map<String, dynamic> json) => DataViewOrganisationUnit(
    id: json["id"],
    level: json["level"],
    name: json["name"],
    path: json["path"],
    children: json["children"] != null
        ? List<DataViewOrganisationUnit>.from(json["children"].map((x) => DataViewOrganisationUnit.fromMap(x)))
        : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "level": level,
    "name": name,
    "path": path,
    if (children != null) "children": List<dynamic>.from(children!.map((x) => x.toMap())),
  };
}

class Parent {
  String? id;

  Parent({
    this.id,

  });

  factory Parent.fromMap(Map<String, dynamic> json) => Parent(
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
  };
}

class Operation {

  String? op;
  String? path;
  dynamic value;

  Operation({
    this.op,
    this.path,
    this.value,
  });

  factory Operation.fromMap(Map<String, dynamic> json) {
    return Operation(
      op: json["op"] as String?,
      path: json["path"] as String?,
      value: json["value"], // Assuming value can be any type.
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (op != null) "op": op!,
      if (path != null) "path": path!,
      if (value != null) "value": value,
    };
  }

}