import 'dart:convert';

UserApproval userApprovalFromJson(String str) =>
    UserApproval.fromJson(json.decode(str));

String userApprovalToJson(UserApproval data) => json.encode(data.toJson());

class UserApproval {
  UserApproval({
    required this.name,
    required this.key,
    required this.data,
    required this.datetime,
  });

  final String name;
  final String key;
  final User data;
  final DateTime datetime;

  factory UserApproval.fromJson(Map<String, dynamic> json) => UserApproval(
    name: json["name"],
    key: json["key"],
    data: User.fromJson(json["data"]),
    datetime: DateTime.parse(json["datetime"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "key": key,
    "data": data.toJson(),
    "datetime": datetime.toIso8601String(),
  };
}

class User {
  User({
    required this.id,
    required this.url,
    required this.action,
    required this.method,
    required this.message,
    required this.payload,
    required this.replyMessage,
    required this.ticketNumber,
  });

  final String id;
  final String url;
  final String action;
  final String method;
  final Message message;
  final PayloadUser payload;
  final String replyMessage;
  final String ticketNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    url: json["url"],
    action: json["action"],
    method: json["method"],
    message: Message.fromJson(json["message"]),
    payload: PayloadUser.fromMap(json["payload"]),
    replyMessage: json["replyMessage"],
    ticketNumber: json["ticketNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "action": action,
    "method": method,
    "message": message.toJson(),
    "payload": payload.toMap(),
    "replyMessage": replyMessage,
    "ticketNumber": ticketNumber,
  };
}
class Message {
  Message({
    required this.message,
    required this.subject,
  });

  final String message;
  final String subject;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"],
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "subject": subject,
  };
}

class PayloadUser {
  final List<Operation>? operations;
  final UserCredentials? userCredentials;
  final List<dynamic>? attributeValues;
  final List<DataViewOrganisationUnit>? dataViewOrganisationUnits;
  final String? phoneNumber;
  final String? referenceId;
  final String? surname;
  final String? name;
  final String? firstName;
  final List<UserGroup>? userGroups;

  PayloadUser({
    this.attributeValues,
    this.dataViewOrganisationUnits,
    this.phoneNumber,
    this.referenceId,
    this.surname,
    this.userCredentials,
    this.userGroups,
    this.operations,
    this.firstName,
    this.name,
  });

  factory PayloadUser.fromMap(Map<String, dynamic> json) {
    return PayloadUser(
      attributeValues: json["attributeValues"] != null
          ? List<dynamic>.from(json["attributeValues"].map((x) => x))
          : null,
      dataViewOrganisationUnits: json["dataViewOrganisationUnits"] != null
          ? List<DataViewOrganisationUnit>.from(
          json["dataViewOrganisationUnits"].map((x) => DataViewOrganisationUnit.fromMap(x)))
          : null,
      phoneNumber: json["phoneNumber"] as String?,
      referenceId: json["referenceId"] as String?,
      surname: json["surname"] as String?,
      name: json["name"] as String?,
      firstName: json["firsName"] as String?,
      userCredentials: json["userCredentials"] != null
          ? UserCredentials.fromMap(json["userCredentials"])
          : null,
      userGroups: json["userGroups"] != null
          ? List<UserGroup>.from(json["userGroups"].map((x) => UserGroup.fromMap(x)))
          : null,
      operations: json["payload"] != null
          ? (json["payload"] as List).map((i) => Operation.fromMap(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (attributeValues != null) "attributeValues": List<dynamic>.from(attributeValues!.map((x) => x)),
      if (dataViewOrganisationUnits != null) "dataViewOrganisationUnits": List<dynamic>.from(dataViewOrganisationUnits!.map((x) => x.toMap())),
      if (phoneNumber != null) "phoneNumber": phoneNumber!,
      if (referenceId != null) "referenceId": referenceId!,
      if (surname != null) "surname": surname!,
      if (firstName != null) "firstName": firstName!,
      if (name != null) "name": name!,
      if (userCredentials != null) "userCredentials": userCredentials!.toMap(),
      if (userGroups != null) "userGroups": List<dynamic>.from(userGroups!.map((x) => x.toMap())),
      if (operations != null) 'payload': operations!.map((operation) => operation.toMap()).toList(),
    };
  }
}



class OrganisationUnit {
  final String id;
  final int level;
  final String name;
  final String path;
  final List<OrganisationUnit>? children;

  OrganisationUnit({
    required this.id,
    required this.level,
    required this.name,
    required this.path,
    this.children,
  });

  factory OrganisationUnit.fromMap(Map<String, dynamic> json) => OrganisationUnit(
    id: json["id"],
    level: json["level"],
    name: json["name"],
    path: json["path"],
    children: json["children"] != null
        ? List<OrganisationUnit>.from(json["children"].map((x) => OrganisationUnit.fromMap(x)))
        : null,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "level": level,
    "name": name,
    "path": path,
    if (children != null) "children": List<dynamic>.from(children!.map((x) => x.toMap())),
  };
}

class Parent {
  final String id;

  Parent({
    required this.id,
  });

  factory Parent.fromMap(Map<String, dynamic> json) => Parent(
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
  };
}

class Operation {
  final String op;
  final String path;
  final dynamic? value;

  Operation({
    required this.op,
    required this.path,
    this.value,
  });

  factory Operation.fromMap(Map<String, dynamic> json) {
    return Operation(
      op: json['op'],
      path: json['path'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'op': op,
      'path': path,
      if (value != null) 'value': value,
    };
  }
}

class UserGroup {
  UserGroup({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory UserGroup.fromMap(Map<String, dynamic> json) =>
      UserGroup(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class UserGroups {
  UserGroups({
    this.userGroups,
  });

  List<UserGroup>? userGroups;

  factory UserGroups.fromMap(Map<String, dynamic> json) =>
      UserGroups(
        userGroups: json["userGroups"] == null
            ? null
            : List<UserGroup>.from(json["userGroups"].map((x) => UserGroup.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {
        "userGroups": userGroups == null
            ? null
            : List<dynamic>.from(userGroups!.map((x) => x.toMap())),
      };
}

class DataViewOrganisationUnit {
  DataViewOrganisationUnit({
    this.id,
    this.level,
    this.name,
  });

  String? id;
  int? level;
  String? name;

  factory DataViewOrganisationUnit.fromMap(Map<String, dynamic> json) =>
      DataViewOrganisationUnit(
        id: json["id"] == null ? null : json["id"],
        level: json["level"] == null ? null : json["level"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "level": level == null ? null : level,
        "name": name == null ? null : name,

      };
}

class DataViewOrganisationUnits {
  DataViewOrganisationUnits({
    this.dataViewOrganisationUnits,
  });

  List<DataViewOrganisationUnit>? dataViewOrganisationUnits;

  factory DataViewOrganisationUnits.fromMap(Map<String, dynamic> json) =>
      DataViewOrganisationUnits(
        dataViewOrganisationUnits: json["dataViewOrganisationUnits"] == null
            ? null
            : List<DataViewOrganisationUnit>.from(json["dataViewOrganisationUnits"].map((x) => DataViewOrganisationUnit.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {
        "dataViewOrganisationUnits": dataViewOrganisationUnits == null
            ? null
            : List<dynamic>.from(dataViewOrganisationUnits!.map((x) => x.toMap())),
      };
}

class UserCredentials {
  UserCredentials({
    this.access,
    this.catDimensionConstraints,
    this.cogsDimensionConstraints,
    this.disabled,
    this.externalAuth,
    this.id,
    this.invitation,
    this.lastLogin,
    this.passwordLastUpdated,
    this.previousPasswords,
    this.selfRegistered,
    this.sharing,
    this.twoFA,
    this.userRoles,
    this.username
  });

  bool? disabled;
  bool? externalAuth;
  bool? selfRegistered;
  bool? twoFA;
  bool? invitation;
  String? username;
  String? id;
  String? lastLogin;
  String? passwordLastUpdated;
  List<PreviousPasswords>? previousPasswords;
  List<CatDimensionConstraints>? catDimensionConstraints;
  List<CogsDimensionConstraints>? cogsDimensionConstraints;
  Sharing? sharing;
  Access? access;
  UserRoles? userRoles;

  factory UserCredentials.fromMap(Map<String, dynamic> json) =>
      UserCredentials(
        id: json["id"] == null ? null : json["id"],
        lastLogin: json["lastLogin"] == null ? null : json["lastLogin"],
        username: json["username"] == null ? null : json["username"],
        selfRegistered: json["id"] == null ? null : json["selfRegistered"],
        externalAuth: json["externalAuth"] == null ? null : json["externalAuth"],
        disabled: json["disabled"] == null ? null : json["disabled"],
        invitation: json["invitation"] == null ? null : json["invitation"],
        twoFA: json["twoFA"] == null ? null : json["twoFA"],
        passwordLastUpdated: json["passwordLastUpdated"] == null ? null : json["passwordLastUpdated"],
        previousPasswords: json["previousPasswords"] == null ? null : List<PreviousPasswords>.from(json["previousPasswords"].map((x) => PreviousPasswords.fromMap(x))),
        catDimensionConstraints: json["catDimensionConstraints"] == null ? null : List<CatDimensionConstraints>.from(json["catDimensionConstraints"].map((x) => CatDimensionConstraints.fromMap(x))),
        cogsDimensionConstraints: json["cogsDimensionConstraints"] == null ? null : List<CogsDimensionConstraints>.from(json["cogsDimensionConstraints"].map((x) => CogsDimensionConstraints.fromMap(x))),
        userRoles: json["userRoles"] == null ? null : UserRoles.fromMap(json["userRoles"]),
        sharing: json["sharing"] == null ? null : Sharing.fromMap(json["sharing"]),
        access: json["access"] == null ? null : Access.fromMap(json["access"]),

      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "lastLogin": lastLogin == null ? null : lastLogin,
        "invitation": invitation == null ? null : invitation,
        "twoFA": twoFA == null ? null : twoFA,
        "selfRegistered": selfRegistered == null ? null : selfRegistered,
        "externalAuth": externalAuth == null ? null : externalAuth,
        "disabled": disabled == null ? null : disabled,
        "passwordLastUpdated": passwordLastUpdated == null ? null : passwordLastUpdated,
        "previousPasswords": previousPasswords == null ? null : List<dynamic>.from(previousPasswords!.map((x) => x.toMap())),
        "catDimensionConstraints": catDimensionConstraints == null ? null : List<dynamic>.from(catDimensionConstraints!.map((x) => x.toMap())),
        "cogsDimensionConstraints": cogsDimensionConstraints == null ? null : List<dynamic>.from(cogsDimensionConstraints!.map((x) => x.toMap())),
        "userRoles": userRoles == null ? null : userRoles!.toMap(),
        "sharing": sharing == null ? null : sharing!.toMap(),
        "access": access == null ? null : access!.toMap(),
      };

}

class PreviousPasswords {
  PreviousPasswords({
    this.previousPasswords,
  });

  List<String>? previousPasswords;

  factory PreviousPasswords.fromMap(Map<String, dynamic> json) =>
      PreviousPasswords(
        previousPasswords: json["previousPasswords"] == null
            ? null
            : List<String>.from(json["previousPasswords"].map((x) => x)),
      );

  Map<String, dynamic> toMap() =>
      {
        "previousPasswords": previousPasswords == null
            ? null
            : List<dynamic>.from(previousPasswords!.map((x) => x)),
      };

}
class CatDimensionConstraints {
  CatDimensionConstraints({
    this.catDimensionConstraints,
  });

  List<String>? catDimensionConstraints;

  factory CatDimensionConstraints.fromMap(Map<String, dynamic> json) =>
      CatDimensionConstraints(
        catDimensionConstraints: json["catDimensionConstraints"] == null
            ? null
            : List<String>.from(json["catDimensionConstraints"].map((x) => x)),
      );

  Map<String, dynamic> toMap() =>
      {
        "catDimensionConstraints": catDimensionConstraints == null
            ? null
            : List<dynamic>.from(catDimensionConstraints!.map((x) => x)),
      };

}

class CogsDimensionConstraints {
  CogsDimensionConstraints({
    this.cogsDimensionConstraints,
  });

  List<String>? cogsDimensionConstraints;

  factory CogsDimensionConstraints.fromMap(Map<String, dynamic> json) =>
      CogsDimensionConstraints(
        cogsDimensionConstraints: json["cogsDimensionConstraints"] == null
            ? null
            : List<String>.from(json["cogsDimensionConstraints"].map((x) => x)),
      );

  Map<String, dynamic> toMap() =>
      {
        "cogsDimensionConstraints": cogsDimensionConstraints == null
            ? null
            : List<dynamic>.from(cogsDimensionConstraints!.map((x) => x)),
      };

}

class UserRoles {
  UserRoles({
    this.userRoles,
  });

  List<UserRole>? userRoles;

  factory UserRoles.fromMap(Map<String, dynamic> json) =>
      UserRoles(

        userRoles: json["userRoles"] == null
            ? null
            : List<UserRole>.from(
            json["userRoles"].map((x) => UserRole.fromMap(x))),
      );

  Map<String, dynamic> toMap() =>
      {
        "userRoles": userRoles == null
            ? null
            : List<dynamic>.from(userRoles!.map((x) => x.toMap())),

      };
}
class UserRole {
  UserRole({
    this.id,
  });

  String? id;


  factory UserRole.fromMap(Map<String, dynamic> json) =>
      UserRole(
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id == null ? null : id,
      };
}

class Access {
  Access({
    this.delete,
    this.externalize,
    this.manage,
    this.read,
    this.update,
    this.write,
  });

  bool? delete;
  bool? externalize;
  bool? manage;
  bool? read;
  bool? update;
  bool? write;

  factory Access.fromMap(Map<String, dynamic> json) => Access(
    delete: json["delete"] == null ? null : json["delete"],
    externalize: json["externalize"] == null ? null : json["externalize"],
    manage: json["manage"] == null ? null : json["manage"],
    read: json["read"] == null ? null : json["read"],
    update: json["update"] == null ? null : json["update"],
    write: json["write"] == null ? null : json["write"],
  );

  Map<String, dynamic> toMap() => {
    "delete": delete == null ? null : delete,
    "externalize": externalize == null ? null : externalize,
    "manage": manage == null ? null : manage,
    "read": read == null ? null : read,
    "update": update == null ? null : update,
    "write": write == null ? null : write,
  };
}

class Sharing {
  Sharing({
    this.external,
    this.userGroups,
    this.users,
  });

  bool? external;
  UserGroups? userGroups;
  Users? users;

  factory Sharing.fromMap(Map<String, dynamic> json) => Sharing(

    external: json["external"] == null ? null : json["external"],
    userGroups: json["userGroups"] == null ? null : UserGroups.fromMap(json["userGroups"]),
    users: json["users"] == null ? null : Users.fromMap(json["users"]),
  );

  Map<String, dynamic> toMap() => {
    "external": external == null ? null : external,
    "userGroups": userGroups == null ? null : userGroups!.toMap(),
    "users": users == null ? null : users!.toMap(),

  };
}
class Users {
  Users({
    this.users,
  });

  Map<String, dynamic>? users;

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    users: json["users"] == null ? {} : Map<String, dynamic>.from(json["users"]),
  );

  Map<String, dynamic> toMap() => {
    "users": users == null ? {} : Map<String, dynamic>.from(users!),
  };
}






