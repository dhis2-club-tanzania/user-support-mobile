import 'package:get/get.dart';

import 'controller/controllers.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Register your controllers here
    Get.put(HomeController());
    Get.put(OrganizationUnitController());
    Get.put(DatastoreController());

    // Add more controllers as needed
  }
}
