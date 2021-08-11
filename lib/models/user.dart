class User {
  String displayName;
  String name;
  String id;
  String username;

  User(
      {required this.displayName,
      required this.name,
      required this.id,
      required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        displayName: json['displayName'].toString(),
        name: json['name'].toString(),
        id: json['id'].toString(),
        username: json['username'].toString());
  }
}
