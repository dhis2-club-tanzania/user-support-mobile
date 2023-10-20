import 'parent..dart';

class Parent {
  int? level;
  String? name;
  String? id;
  Parent? parent;

  Parent({this.level, this.name, this.id, this.parent});

  @override
  String toString() {
    return 'Parent(level: $level, name: $name, id: $id, parent: $parent)';
  }

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        level: json['level'] as int?,
        name: json['name'] as String?,
        id: json['id'] as String?,
        parent: json['parent'] == null
            ? null
            : Parent.fromJson(json['parent'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'level': level,
        'name': name,
        'id': id,
        'parent': parent?.toJson(),
      };

  Parent copyWith({
    int? level,
    String? name,
    String? id,
    Parent? parent,
  }) {
    return Parent(
      level: level ?? this.level,
      name: name ?? this.name,
      id: id ?? this.id,
      parent: parent ?? this.parent,
    );
  }
}
