import 'user.dart';

class UserMessages {
    UserMessages({
        required this.users,
    });

    final User? users;

    factory UserMessages.fromJson(Map<String, dynamic> json) => UserMessages(
        users: json['user'] != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null,
    );
}