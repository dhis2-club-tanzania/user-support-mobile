import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_support_mobile/widgets/custom_widget.dart';

import '../controller/controllers.dart';

class OrgUnitPage extends StatelessWidget {
  final DatastoreController itemsController = Get.put(DatastoreController());
  final OrganizationUnitController orgUnitController =
      Get.put(OrganizationUnitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organisation Units'),
      ),
      body: Obx(() {
        var data = orgUnitController.organizationUnits.value;
        var page = data.pager!;
        if (orgUnitController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: data.organisationUnits!.length,
            itemBuilder: (context, index) {
              if (index == data.organisationUnits!.length - 1) {
                // When the user scrolls to the last item, load more data
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  orgUnitController.fetchOrganizationUnits();
                });
              }
              // return Card(
              //   child: ListTile(
              //     title: Text(
              //         "${data.organisationUnits![index].parent!.parent!.name}, ${data.organisationUnits![index].parent!.name}, ${data.organisationUnits![index].name}"),
              //     // leading: Text(
              //     //     ((page.page! - 1) * page.pageSize!.toInt() + index + 1)
              //     // .toString()),
              //   ),
              // );
              return CustomWidget(
                line1:
                    "${data.organisationUnits![index].parent!.parent!.name}, ${data.organisationUnits![index].parent!.name}, ${data.organisationUnits![index].name}",
                line2:
                    "Datasets & Programs: ${(data.organisationUnits![index].programs! + data.organisationUnits![index].dataSets!.toInt())}",
                line3: 'line3',
                line4: 'line4',
                button1Text: 'button1Text',
                button2Text: 'button2Text',
              );
            },
          );
        }
      }),
    );
  }
}
