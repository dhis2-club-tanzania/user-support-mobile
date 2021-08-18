import 'package:json_annotation/json_annotation.dart';

part 'message_conversation.g.dart';

@JsonSerializable()
class MessageConversation {
  MessageConversation({
    required this.messageType,
    required this.displayName,
    required this.subject,
    required this.followUp,
    // required this.lastUpdated,
    // required this.created,
    // required this.messageCount,
    // required this.id,
    required this.read,
    // required this.name,
    // required this.lastMessage,
  });

  // final String messageCount;
  final bool followUp;
  // final String lastUpdated;
  // final String id;
  final bool read;
  // final String created;
  // final String name;
  final String subject;
  final String displayName;
  final String messageType;
  // final String lastMessage;

  factory MessageConversation.fromJson(Map<String, dynamic> json) =>
      _$MessageConversationFromJson(json);
}
