import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:get/get.dart';

import '../constants/d2-repository.dart';
import '../models/approve_model.dart';
import '../models/org_unit_model/org_unit_model.dart';


class HomeController extends GetxController {
  Future<List<ApproveModel>> fetchData() async {
    try {
      var response = <dynamic>[];

      final res =
      await d2repository.httpClient.get('dataStore/dhis2-user-support');

      var list = res.body;

      for (var i = 1; i < list.length; i++) {
        print('dataStore/dhis2-user-support/${list[i]}');

        if (list[i].toString() != "configurations") {
          final res2 = await d2repository.httpClient
              .get('dataStore/dhis2-user-support/${list[i].toString()}');
          response.add(res2.body);
        }
      }

      final dataApprovalList = response
          .map((x) => ApproveModel.fromMap(x as Map<String, dynamic>))
          .toList();

      return dataApprovalList;
    } catch (e) {
      print("error message: $e");
      return [];
    }
  }
}

class DatastoreController extends GetxController {
  var dataApproval = <ApproveModel>[].obs;
  var userApproval = <UserModel>[].obs; // Added for UserModel
  var isLoading = false.obs;
  var currentPage = 1;

  @override
  void onInit() {
    print("inside Initfx");

    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      final res =
      await d2repository.httpClient.get('dataStore/dhis2-user-support');

      var list = res.body;

      for (var i = 1; i < list.length; i++) {
        if (list[i] != "configurations" &&
            list[i] != 'UA1696233802239_Yc6Dt4UL6yl' &&
            list[i] != 'UA1689236089880_m0frOspS7JY') {
          final res2 = await d2repository.httpClient
              .get('dataStore/dhis2-user-support/${list[i]}');

          // Parse the JSON response
          final jsonResponse = res2.body;

          if (jsonResponse is List) {
            // If it's a List, map it to both ApproveModel and UserModel if applicable
            dataApproval.addAll(
                jsonResponse.map((x) => ApproveModel.fromMap(x)).toList());

            userApproval.addAll(
                jsonResponse.map((x) => UserModel.fromMap(x)).toList());
          } else if (jsonResponse is Map) {
            print('dataStore/dhis2-user-support/${list[i]}');

            // Add to ApproveModel list
            dataApproval.add(
                ApproveModel.fromMap(jsonResponse as Map<String, dynamic>));

            // Add to UserModel list
            userApproval.add(
                UserModel.fromMap(jsonResponse));
          }
        }
      }

      isLoading.value = false;
    } catch (e) {
      print("error message: $e");
      isLoading.value = false;
    }
  }
}

class OrganizationUnitController extends GetxController {
  var organizationUnits = OrgUnitModel().obs;
  var isLoading = false.obs;
  var currentPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchOrganizationUnits();
  }

  Future<void> fetchOrganizationUnits() async {
    try {
      isLoading.value = true;

      final apiResponse = await d2repository.httpClient.get(
          "organisationUnits.json?page=$currentPage&pageSize=50&filter=level:eq:4&fields=id,name,dataSets~size,programs~size,closedDate,parent[id,name,level,parent[id,name,level]]&filter=path:ilike:m0frOspS7JY");
      organizationUnits.value = OrgUnitModel.fromJson(apiResponse.body);

      isLoading.value = false;
      currentPage++;
    } catch (e) {
      print("Error: $e");
      isLoading.value = false;
    }
  }
}