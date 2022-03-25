import 'user.dart';

class Sharing {
  Sharing({
    required this.sharingExternal,
    required this.users,
    required this.userGroups,
  });

  final String sharingExternal;
  final User users;
  final User userGroups;

  factory Sharing.fromJson(Map<String, dynamic> json) => Sharing(
        sharingExternal: json["external"].toString(),
        users: User.fromJson(json["users"] as Map<String, dynamic>),
        userGroups: User.fromJson(json["userGroups"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "external": sharingExternal,
        "users": users.toJson(),
        "userGroups": userGroups.toJson(),
      };
}
