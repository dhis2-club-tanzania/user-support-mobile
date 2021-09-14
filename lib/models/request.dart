class DataRequest {
  DataRequest({
    required this.action,
    required this.method,
    required this.payload,
    required this.status,
    required this.url,
  });

  final String action;
  final String method;
  final Payload payload;
  final String status;
  final String url;

  factory DataRequest.fromJson(Map<String, dynamic> json) => DataRequest(
        action: json["action"].toString(),
        method: json["method"].toString(),
        payload: Payload.fromJson(json["payload"] as Map<String, dynamic>),
        status: json["status"].toString(),
        url: json["url"].toString(),
      );
}

class Payload {
  Payload({
    required this.id,
    required this.name,
    required this.organisationUnits,
    required this.periodType,
  });

  final String id;
  final String name;
  final List<OrganisationUnit> organisationUnits;
  final String periodType;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"].toString(),
        name: json["name"].toString(),
        organisationUnits: List<OrganisationUnit>.from(
          json["organisationUnits"].map(
            (x) => OrganisationUnit.fromJson(x as Map<String, dynamic>),
          ) as Iterable,
        ),
        periodType: json["periodType"].toString(),
      );
}

class OrganisationUnit {
  OrganisationUnit({
    required this.id,
  });

  final String id;

  factory OrganisationUnit.fromJson(Map<String, dynamic> json) =>
      OrganisationUnit(
        id: json["id"].toString(),
      );
}
