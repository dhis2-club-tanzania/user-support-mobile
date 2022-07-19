// To parse this JSON data, do
//
//     final approveModel = approveModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ApproveModel approveModelFromMap(String str) => ApproveModel.fromMap(json.decode(str));

String approveModelToMap(ApproveModel data) => json.encode(data.toMap());

class ApproveModel {
    ApproveModel({
        required this.id,
        required this.url,
        required this.user,
        required this.action,
        required this.method,
        required this.status,
        required this.message,
        required this.payload,
        required this.actionType,
        required this.shouldAlert,
        required this.replyMessage,
        required this.ticketNumber,
        required this.messageConversation,
        required this.timeSinceResponseSent,
        required this.rejectionReasonMessage,
    });

    String? id;
    String? url;
    UserData? user;
    String? action;
    String? method;
    String? status;
    Message? message;
    Payload? payload;
    String? actionType;
    bool? shouldAlert;
    String? replyMessage;
    String? ticketNumber;
    MessageConvo? messageConversation;
    String? timeSinceResponseSent;
    String? rejectionReasonMessage;

    factory ApproveModel.fromMap(Map<String, dynamic> json) => ApproveModel(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        user: json["user"] == null ? null : UserData.fromMap(json["user"]),
        action: json["action"] == null ? null : json["action"],
        method: json["method"] == null ? null : json["method"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : Message.fromMap(json["message"]),
        payload: json["payload"] == null ? null : Payload.fromMap(json["payload"]),
        actionType: json["actionType"] == null ? null : json["actionType"],
        shouldAlert: json["shouldAlert"] == null ? null : json["shouldAlert"],
        replyMessage: json["replyMessage"] == null ? null : json["replyMessage"],
        ticketNumber: json["ticketNumber"] == null ? null : json["ticketNumber"],
        messageConversation: json["messageConversation"] == null ? null : MessageConvo.fromMap(json["messageConversation"]),
        timeSinceResponseSent: json["timeSinceResponseSent"] == null ? null : json["timeSinceResponseSent"],
        rejectionReasonMessage: json["rejectionReasonMessage"] == null ? null : json["rejectionReasonMessage"],
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
        "messageConversation": messageConversation == null ? null : messageConversation!.toMap(),
        "timeSinceResponseSent": timeSinceResponseSent == null ? null : timeSinceResponseSent,
        "rejectionReasonMessage": rejectionReasonMessage == null ? null : rejectionReasonMessage,
    };
}

class Message {
    Message({
        required this.message,
        required this.subject,
        required this.messageContentsLength,
    });

    final String message;
    final String subject;
    final int messageContentsLength;

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        message: json["message"] == null ? null : json["message"],
        subject: json["subject"] == null ? null : json["subject"],
        messageContentsLength: json["messageContentsLength"] == null ? null : json["messageContentsLength"],
    );

    Map<String, dynamic> toMap() => {
        "message": message == null ? null : message,
        "subject": subject == null ? null : subject,
        "messageContentsLength": messageContentsLength == null ? null : messageContentsLength,
    };
}

class MessageConvo {
    MessageConvo({
        required this.id,
        required this.displayName,
    });

    final String id;
    final String displayName;

    factory MessageConvo.fromMap(Map<String, dynamic> json) => MessageConvo(
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
        required this.additions,
        required this.deletions,
    });

    final List<Addition>? additions;
    final List<Addition>? deletions;

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        additions: json["additions"] == null ? null : List<Addition>.from(json["additions"].map((x) => Addition.fromMap(x))),
        deletions: json["deletions"] == null ? null : List<Addition>.from(json["deletions"].map((x) => Addition.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "additions": additions == null ? null : List<dynamic>.from(additions!.map((x) => x.toMap())),
        "deletions": deletions == null ? null : List<dynamic>.from(deletions!.map((x) => x.toMap())),
    };
}

class Addition {
    Addition({
        required this.id,
        required this.name,
    });

    final String id;
    final String name;

    factory Addition.fromMap(Map<String, dynamic> json) => Addition(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}

class UserData {
    UserData({
        required this.id,
        required this.email,
        required this.jobTitle,
        required this.userName,
        required this.displayName,
        required this.phoneNumber,
        required this.organisationUnits,
    });

    final String id;
    final String email;
    final String jobTitle;
    final String userName;
    final String displayName;
    final String phoneNumber;
    final List<Addition>? organisationUnits;

    factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        jobTitle: json["jobTitle"] == null ? null : json["jobTitle"],
        userName: json["userName"] == null ? null : json["userName"],
        displayName: json["displayName"] == null ? null : json["displayName"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        organisationUnits: json["organisationUnits"] == null ? null : List<Addition>.from(json["organisationUnits"].map((x) => Addition.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "jobTitle": jobTitle == null ? null : jobTitle,
        "userName": userName == null ? null : userName,
        "displayName": displayName == null ? null : displayName,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "organisationUnits": organisationUnits == null ? null : List<dynamic>.from(organisationUnits!.map((x) => x.toMap())),
    };
}
