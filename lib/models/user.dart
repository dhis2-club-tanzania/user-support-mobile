class User {
  User({
    required this.displayName,
    required this.name,
    required this.id,
    required this.username,
  });

  final String displayName;
  final String name;
  final String id;
  final String username;

  factory User.fromJson(Map<String, dynamic> json) => User(
        displayName: json["displayName"].toString(),
        name: json["name"].toString(),
        id: json["id"].toString(),
        username: json["username"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "name": name,
        "id": id,
        "username": username,
      };
}
