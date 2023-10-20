import 'parent..dart';

class OrganisationUnit {
  String? name;
  String? id;
  int? dataSets;
  int? programs;
  Parent? parent;
  DateTime? closedDate;

  OrganisationUnit({
    this.name,
    this.id,
    this.dataSets,
    this.programs,
    this.parent,
    this.closedDate,
  });

  @override
  String toString() {
    return 'OrganisationUnit(name: $name, id: $id, dataSets: $dataSets, programs: $programs, parent: $parent, closedDate: $closedDate)';
  }

  factory OrganisationUnit.fromJson(Map<String, dynamic> json) {
    return OrganisationUnit(
      name: json['name'] as String?,
      id: json['id'] as String?,
      dataSets: json['dataSets'] as int?,
      programs: json['programs'] as int?,
      parent: json['parent'] == null
          ? null
          : Parent.fromJson(json['parent'] as Map<String, dynamic>),
      closedDate: json['closedDate'] == null
          ? null
          : DateTime.parse(json['closedDate'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'dataSets': dataSets,
        'programs': programs,
        'parent': parent?.toJson(),
        'closedDate': closedDate?.toIso8601String(),
      };

  OrganisationUnit copyWith({
    String? name,
    String? id,
    int? dataSets,
    int? programs,
    Parent? parent,
    DateTime? closedDate,
  }) {
    return OrganisationUnit(
      name: name ?? this.name,
      id: id ?? this.id,
      dataSets: dataSets ?? this.dataSets,
      programs: programs ?? this.programs,
      parent: parent ?? this.parent,
      closedDate: closedDate ?? this.closedDate,
    );
  }
}
