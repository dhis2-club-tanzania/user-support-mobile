import 'package:user_support_mobile/models/user.dart';

class Message {
  final String displayName;
  final User? user;
  final String subject;
  final String messageType;

  Message({
    required this.messageType,
    required this.displayName,
    required this.user,
    required this.subject,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      displayName: json['displayName'].toString(),
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      subject: json['subject'].toString(),
      messageType: json['messageType'].toString(),
    );
  }
}
