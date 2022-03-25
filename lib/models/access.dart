class Access {
  Access({
    required this.read,
    required this.update,
    required this.externalize,
    required this.delete,
    required this.write,
    required this.manage,
  });

  final bool read;
  final bool update;
  final bool externalize;
  final bool delete;
  final bool write;
  final bool manage;

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        read: json["read"] as bool,
        update: json["update"] as bool,
        externalize: json["externalize"] as bool,
        delete: json["delete"] as bool,
        write: json["write"] as bool,
        manage: json["manage"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "read": read,
        "update": update,
        "externalize": externalize,
        "delete": delete,
        "write": write,
        "manage": manage,
      };
}
