class UserGroups {
  UserGroups({
    required this.displayName,
    required this.id,
  });

  final String displayName;
  final String id;

  factory UserGroups.fromJson(Map<String, dynamic> json) => UserGroups(
        displayName: json["displayName"].toString(),
        id: json["id"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "id": id,
      };
}
