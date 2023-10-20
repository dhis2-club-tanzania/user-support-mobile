import 'organisation_unit..dart';
import 'pager..dart';

class OrgUnitModel {
  Pager? pager;
  List<OrganisationUnit>? organisationUnits;

  OrgUnitModel({this.pager, this.organisationUnits});

  @override
  String toString() {
    return 'OrgUnitModel(pager: $pager, organisationUnits: $organisationUnits)';
  }

  factory OrgUnitModel.fromJson(Map<String, dynamic> json) => OrgUnitModel(
        pager: json['pager'] == null
            ? null
            : Pager.fromJson(json['pager'] as Map<String, dynamic>),
        organisationUnits: (json['organisationUnits'] as List<dynamic>?)
            ?.map((e) => OrganisationUnit.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'pager': pager?.toJson(),
        'organisationUnits': organisationUnits?.map((e) => e.toJson()).toList(),
      };

  OrgUnitModel copyWith({
    Pager? pager,
    List<OrganisationUnit>? organisationUnits,
  }) {
    return OrgUnitModel(
      pager: pager ?? this.pager,
      organisationUnits: organisationUnits ?? this.organisationUnits,
    );
  }
}
