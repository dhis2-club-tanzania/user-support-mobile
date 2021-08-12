import 'package:user_support_mobile/models/user.dart';

class MessageConversation {
  MessageConversation({
    required this.messageType,
    required this.displayName,
    required this.subject,
    required this.user,
  });

  late final String messageType;
  final String displayName;
  final String subject;
  final User? user;

  factory MessageConversation.fromJson(Map<String, dynamic> json) =>
      MessageConversation(
        messageType: json["messageType"].toString(),
        displayName: json["displayName"].toString(),
        subject: json["subject"].toString(),
        user: json["user"] == null
            ? null
            : User.fromJson(json["user"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "messageType": messageType,
        "displayName": displayName,
        "subject": subject,
        "user": user == null ? null : user!.toJson(),
      };
}
