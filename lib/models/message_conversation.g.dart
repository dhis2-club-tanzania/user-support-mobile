// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageConversation _$MessageConversationFromJson(Map<String, dynamic> json) {
  return MessageConversation(
    messageType: json['messageType'] as String,
    displayName: json['displayName'] as String,
    subject: json['subject'] as String,
    followUp: json['followUp'] as bool,
    read: json['read'] as bool,
  );
}

Map<String, dynamic> _$MessageConversationToJson(
        MessageConversation instance) =>
    <String, dynamic>{
      'followUp': instance.followUp,
      'read': instance.read,
      'subject': instance.subject,
      'displayName': instance.displayName,
      'messageType': instance.messageType,
    };
