class Message {
  final String displayName;
  final String user;
  final String subject;

  Message({
    required this.displayName,
    required this.user,
    required this.subject,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    print('this is a breakpoint');
    print(json['messageConversations'][0]['user'].toString());
    return Message(
      displayName: json['displayName'].toString(),
      user: json['messageConversations'][0]['user'].toString(),
      subject: json['messageConversations'][0]['subject'].toString(),
    );
  }
}
