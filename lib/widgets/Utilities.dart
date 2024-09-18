
import 'package:flutter/material.dart';

import '../models/approve_model.dart';

class UserUtils {
  static List<dynamic> addAccountData(UserModel? userModel) {
    final List<dynamic> account = [];
    if (userModel?.userPayload != null) {
      for (var payload in userModel!.userPayload!) {
        account.add({
          'SN': (account.length + 1).toString(),
          'Names': '${payload.firstName ?? ''} ${payload.surname ?? ''}',
          'Email': payload.email ?? '',
          'Phone Number': payload.phoneNumber ?? '',
          'payloadStatus': payload.status ?? '',
          'Entry Access Level': _getDataEntryAccessLevel(payload),
          'Report Access Level': _getReportAccessLevel(payload),
        });
      }
    }
    return account;
  }

  static String _getDataEntryAccessLevel(Userpayload payload) {
    final organisationUnitNames = payload.organisationUnits
        ?.map((unit) => unit.name)
        .toList() ?? [];

    final childrenNames = payload.organisationUnits
        ?.expand((unit) => unit.children?.map((child) => child.name) ?? <String>[])
        .toList() ?? [];

    return [...organisationUnitNames, ...childrenNames].join(', ');
  }

  static String _getReportAccessLevel(Userpayload payload) {
    final dataViewOrganisationUnitNames = payload.dataViewOrganisationUnits
        ?.map((unit) => unit.name)
        .toList() ?? [];

    final childrenNames = payload.dataViewOrganisationUnits
        ?.expand((unit) => unit.children?.map((child) => child.name) ?? <String>[])
        .toList() ?? [];

    return [...dataViewOrganisationUnitNames, ...childrenNames].join(', ');
  }



}


