import 'dart:convert';

DataApproval dataApprovalFromJson(String str) =>
    DataApproval.fromJson(json.decode(str));

String dataApprovalToJson(DataApproval data) => json.encode(data.toJson());

class DataApproval {
  DataApproval({
    required this.name,
    required this.key,
    required this.data,
    required this.datetime,
  });

  final String name;
  final String key;
  final Data data;
  final DateTime datetime;

  factory DataApproval.fromJson(Map<String, dynamic> json) => DataApproval(
        name: json["name"],
        key: json["key"],
        data: Data.fromJson(json["data"]),
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "data": data.toJson(),
        "datetime": datetime.toIso8601String(),
      };
}

class Data {
  Data({
    required this.id,
    required this.url,
    required this.action,
    required this.method,
    required this.message,
    required this.payload,
    required this.replyMessage,
    required this.ticketNumber,
  });

  final String id;
  final String url;
  final String action;
  final String method;
  final Message message;
  final Payload payload;
  final String replyMessage;
  final String ticketNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        url: json["url"],
        action: json["action"],
        method: json["method"],
        message: Message.fromJson(json["message"]),
        payload: Payload.fromJson(json["payload"]),
        replyMessage: json["replyMessage"],
        ticketNumber: json["ticketNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "action": action,
        "method": method,
        "message": message.toJson(),
        "payload": payload.toJson(),
        "replyMessage": replyMessage,
        "ticketNumber": ticketNumber,
      };
}

class Message {
  Message({
    required this.message,
    required this.subject,
  });

  final String message;
  final String subject;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "subject": subject,
      };
}

class Payload {
  Payload({
    required this.additions,
    required this.deletions,
  });

  final List<Tion> additions;
  final List<Tion> deletions;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        additions:
            List<Tion>.from(json["additions"].map((x) => Tion.fromJson(x))),
        deletions:
            List<Tion>.from(json["deletions"].map((x) => Tion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "additions": List<dynamic>.from(additions.map((x) => x.toJson())),
        "deletions": List<dynamic>.from(deletions.map((x) => x.toJson())),
      };
}

class Tion {
  Tion({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Tion.fromJson(Map<String, dynamic> json) => Tion(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
