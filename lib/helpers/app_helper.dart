// ignore_for_file: empty_catches, must_be_immutable

import 'dart:convert';

import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/data/data_store/entities/data_store.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/models/geometry.dart';
import 'package:d2_touch/modules/data/tracker/models/tracked_entity_instance_import_summary.model.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:d2_touch/shared/models/import_status.model.dart';
import 'package:d2_touch/shared/utilities/orgunit_mode.util.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_support_mobile/constants/d2-repository.dart';
import 'package:user_support_mobile/helpers/colors.dart';

class AppHelpers {
  static snackBar(String message, Color appColor, Color? textColor,
      {String? title, SnackPosition? position, int? duration}) async {
    await closeSnackBar();
    if (message != '' &&
        !message.contains('NoSuch') &&
        !message.contains('List<dynamic>')) {
      Get.snackbar(
          title ??
              ((appColor == Colors.red || appColor == Colors.redAccent)
                  ? 'Error'
                  : 'Info'),
          message,
          snackPosition: position ?? SnackPosition.TOP,
          duration: Duration(seconds: duration ?? 5),
          backgroundColor: appColor,
          messageText: Text(message));
    }
  }

  static closeSnackBar({bool stay = false}) async {
    if (Get.isSnackbarOpen) {
      await Get.closeCurrentSnackbar();
    }

    if (stay) {
      Get.back(result: 'stay');
    }
  }

  static Widget buildActionButton(
      Color actionButtonColor, Icon? icon, Widget? label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: actionButtonColor),
          child: icon ?? label,
        )
      ],
    );
  }

  static Widget buildStatusTag(String status, Color color) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Text(
        status,
        style:
            TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  static String dateHelper(Duration date) {
    int days = date.inDays;
    int hours = date.inHours % 24;
    int minutes = date.inMinutes % 60;
    int seconds = date.inSeconds % 60;

    return days >= 1
        ? '$days ${days > 1 ? 'days' : 'day'} ago'
        : hours >= 1
            ? '$hours ${hours > 1 ? 'hours' : 'hour'} ago'
            : minutes >= 1
                ? '$minutes ${minutes > 1 ? 'minutes' : 'minute'} ago'
                : '$seconds ${seconds > 1 ? 'seconds' : 'second'} ago';
  }

  static showAlertDialog(
      BuildContext context, TextEditingController? textController) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textController != null
                  ? TextButton(
                      onPressed: () {
                        Get.back();
                        searchDialog(context, textController);
                      },
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : const SizedBox(),
              TextButton(
                onPressed: () {
                  Get.back();
                  logout();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  static logoutUser() async {
    await d2repository.authModule.logOut();
    await d2repository.userModule.userOrganisationUnit.delete();
    await d2repository.userModule.userAuthority.delete();
    await d2repository.userModule.userRole.delete();
    await d2repository.userModule.user.delete();
    await d2repository.trackerModule.trackedEntityAttributeValue.delete();
    await d2repository.trackerModule.eventDataValue.delete();
    await d2repository.trackerModule.event.delete();
    await d2repository.trackerModule.enrollment.delete();
    await d2repository.trackerModule.trackedEntityInstance.delete();
    await d2repository.aggregateModule.dataValue.delete();
    await d2repository.aggregateModule.dataValueSet.delete();
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.remove('databaseName');
    Get.toNamed('/login');
  }

  static logout({bool? dontShowMessage}) async {
    if (dontShowMessage != null && dontShowMessage) {
      await logoutUser();
      return;
    }
    bool shouldLogout = await getLogoutAlert();
    if (shouldLogout) {
      await logoutUser();
    }
  }

  static List<String> getAuthorities(User? user) {
    User? currentUser = (user ?? appUser);
    return (currentUser?.authorities ?? [])
        .map((authority) => authority.authority)
        .toList();
  }

  static bool canShowTheContactCard(User user, String menuItemName) {
    final authorities =
        user.authorities?.map((authority) => authority.authority).toList() ??
            [];

    if (menuItemName == 'Tracers' &&
        !authorities.contains('SUPER_USERS') &&
        !authorities.contains('IDSR_VIEW_SUPERVISORS') &&
        !authorities.contains('IDSR_VIEW_TRACERS')) {
      return false;
    }
    return true;
  }

  static searchDialog(
      BuildContext context, TextEditingController textController) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(labelText: 'Search'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> getEventVerification(
      TrackedEntityInstance trackedEntityInstance) async {
    // return true;
    ProgramTrackedEntityAttribute? alertRefrence = await d2repository
        .programModule.programTrackedEntityAttribute
        .where(attribute: 'code', value: 'ALERT_REF_ID')
        .getOne();

    TrackedEntityAttributeValue trackedEntity = trackedEntityInstance
        .attributes!
        .firstWhere((element) => element.attribute == alertRefrence?.attribute,
            orElse: () => TrackedEntityAttributeValue(
                attribute: '',
                dirty: false,
                trackedEntityInstance: null,
                value: ''));
    if (trackedEntity.value != '') {
      return true;
    }

    if (trackedEntity.value == '') {
      return false;
    }

    String query =
        "SELECT tv.trackedEntityInstance FROM trackedEntityAttributeValue tv INNER JOIN enrollment en ON(en.trackedEntityInstance=tv.trackedEntityInstance) INNER JOIN program p ON(p.id=en.program) WHERE p.code='OUTBREAK_NOTIFICATION' AND tv.value='${trackedEntity.value}'";

    List<dynamic> eventValue =
        await d2repository.engine.query.execute(query: query, args: []);

    if (eventValue.isEmpty) {
      return false;
    }

    query =
        "SELECT * FROM trackedEntityAttributeValue WHERE trackedEntityInstance='${eventValue[0]['trackedEntityInstance']}' AND attribute IN(SELECT attribute FROM programtrackedentityattribute WHERE code='TRUE_ALERT')";
    List<dynamic> verifiedEvent =
        await d2repository.engine.query.execute(query: query, args: []);

    return verifiedEvent.isNotEmpty && verifiedEvent[0]['value'] == 'Yes';
  }

  static Future<DataStore> getDataStore(
      {required String namespace, required String key}) async {
    DataStore dataStore =
        DataStore(namespace: '', key: '', value: '', dirty: false);
    List<dynamic> data = await d2repository.engine.query.execute(
        args: [],
        query:
            "SELECT * FROM dataStore WHERE namespace='$namespace' AND key='$key';");
    if (data.isNotEmpty) {
      dataStore = DataStore(
          namespace: data[0]['namespace'],
          key: data[0]['key'],
          value: data[0]['value'],
          dirty: data[0]['dirty'] == 0 ? false : true);
    }
    return dataStore;
  }

  // static Future<CurrentUserMenuList> getTheCurrentUser() async {
  //   DataStore dataStore =
  //       await getDataStore(namespace: 'eidsr', key: 'mobile-menu');
  //   DataStore? instance =
  //       await getDataStore(namespace: 'eidsr', key: 'instance');

  //   appInstance = getInstance(instance.value);

  //   User user = await d2repository.userModule.user
  //       .withAuthorities()
  //       .where(attribute: 'isLoggedIn', value: true)
  //       .getOne();
  //   return CurrentUserMenuList(dataStore: dataStore, user: user);
  // }

  static bool shouldShow(
      List<String> userAuthorities, List<String> appAuthorities) {
    bool shouldShow = false;
    for (String authority in appAuthorities) {
      if (userAuthorities.contains(authority)) {
        shouldShow = true;
      }
    }
    return shouldShow;
  }

  static getInnerMenu(List<dynamic> menus, List<String> userAuthorities) {
    List<dynamic> cleanMenu = [];
    for (var menu in menus) {
      if (shouldShow(
          userAuthorities, List<String>.from(menu['authorities'] ?? []))) {
        cleanMenu.add(menu);
      }
    }
    return cleanMenu;
  }

  static String getInstance(dynamic value) {
    try {
      dynamic decodeValue = jsonDecode(value);
      if (decodeValue['status'] == 'ERROR') return 'TANZANIA';
      return decodeValue['name'];
    } catch (e) {
      return 'TANZANIA';
    }
  }

  static PreferredSizeWidget getAppBar({String? name, Widget? leadingAction}) {
    return AppBar(title: Text(name ?? ''), actions: [
      if (leadingAction != null) leadingAction,
      IconButton(
        onPressed: () async {
          await AppHelpers.logout();
        },
        icon: const Icon(Icons.logout),
      ),
    ]);
  }

  static List<dynamic> getMobileMenuList(
      List<dynamic> menus, List<String> userAuthorities) {
    var mobileMenus = (menus.where((menu) => shouldShow(
            userAuthorities, List<String>.from(menu['authorities'] ?? []))))
        .toList();
    List<dynamic> cleanMenu = [];
    for (var menu in mobileMenus) {
      if (shouldShow(
              userAuthorities, List<String>.from(menu['authorities'] ?? [])) &&
          menu['menuItems'].length > 0) {
        menu['icon'] =
            IconData(int.parse(menu['icon']), fontFamily: 'MaterialIcons');

        menu['disabled'] = (menu['disabled'] ?? [])
            .map((data) => DisabledList(disabled: data));
        List<dynamic> subMenu =
            getInnerMenu(menu['menuItems'], userAuthorities);

        menu['menuItems'] = subMenu;
        if (subMenu.isNotEmpty) {
          cleanMenu.add(menu);
        }
      }
    }
    cleanMenu.sort((a, b) => (a['sort']) - (b['sort']));
    return cleanMenu;
  }

  static Future<bool> isConnected() async {
    return await InternetConnectionCheckerPlus().connectionStatus ==
        InternetConnectionStatus.connected;
  }

  // static showSelectedLocation(Position location) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(location.latitude, location.longitude);
  //     Placemark place = placemarks[0];
  //     AppHelpers.snackBar(
  //         getLocationName(place), Colors.greenAccent, Colors.black,
  //         title: 'Location');
  //   } catch (e) {
  //     //
  //   }
  // }

  // static String getLocationName(Placemark place) {
  //   return '${place.street != null && place.street != '' && !place.street!.contains('+') ? '${place.street},' : ''} ${place.subLocality != null && place.subLocality != '' ? '${place.subLocality},' : ''} ${place.subAdministrativeArea != null && place.subAdministrativeArea != '' ? '${place.subAdministrativeArea},' : ''} ${place.postalCode != null ? '${place.postalCode}' : ''}';
  // }

  // static Future<void> addLocationToEnrollment(
  //     {Enrollment? enrollment, Position? location}) async {
  //   try {
  //     if (enrollment != null && location != null) {
  //       enrollment.geometry = Geometry(
  //           type: 'Point',
  //           latitude: location.latitude,
  //           longitude: location.longitude,
  //           geometryData: {
  //             'type': 'Point',
  //             'latitude': location.latitude,
  //             'longitude': location.longitude,
  //             'coordinates': [location.longitude, location.latitude]
  //           });
  //       await d2repository.trackerModule.enrollment.setData(enrollment).save();
  //       await showSelectedLocation(location);
  //     }
  //   } catch (e) {
  //     //
  //   }
  // }

  static Future<void> syncData(
      {String? trackedEntityInstance,
      bool reroute = false,
      bool downloading = false,
      bool showNoInternet = false}) async {
    if (!(await AppHelpers.isConnected())) {
      if (showNoInternet) {
        noInternetWarning();
      }
      if (reroute) {
        Get.back();
      }
      return;
    }
    try {
      await downloadData(
          trackedEntityInstance: trackedEntityInstance,
          downloading: downloading);
      await d2repository.fileResourceModule.fileResource.upload((p0, p1) {});
      if (trackedEntityInstance != null) {
        List<TrackedEntityInstance> teiSynchronizationResponse =
            await d2repository.trackerModule.trackedEntityInstance
                .byId(trackedEntityInstance)
                .upload((p0, p1) {});

        if (teiSynchronizationResponse.isNotEmpty &&
            teiSynchronizationResponse[0].syncFailed == true) {
          getSummary(teiSynchronizationResponse[0].lastSyncSummary);
        }
      } else {
        await d2repository.trackerModule.trackedEntityInstance
            .upload((p0, p1) {});
      }
    } catch (e) {
      snackBar(e.toString(), Colors.red, Colors.black);
    }
    if (reroute) {
      Get.back();
    }
  }

  static Future<void> downloadData(
      {String? trackedEntityInstance, bool? downloading}) async {
    if (!await AppHelpers.isConnected()) {
      AppHelpers.noInternetWarning();
      return;
    }
    try {
      if (trackedEntityInstance != null) {
        await d2repository.trackerModule.trackedEntityInstance
            .byId(trackedEntityInstance)
            .download((p0, p1) {});
        return;
      }
      if (downloading != null) {
        await d2repository.trackerModule.trackedEntityInstance
            .download((p0, p1) {});
      }
    } catch (e) {}
  }

  static Future<void> downloadAllData() async {
    List<Program> programs = await d2repository.programModule.program.get();
    for (Program program in programs) {
      try {
        await d2repository.trackerModule.trackedEntityInstance
            .byProgram(program.id.toString())
            .byUserOrgUnit()
            .withOuMode(OrgUnitMode.DESCENDANTS)
            .download((progress, completed) {});
      } catch (e) {}
    }
    await AppHelpers.syncData();
  }

  static Future<void> syncEvent(String? id) async {
    try {
      if (id != null) {
        await downloadEvent(id: id);
        await d2repository.trackerModule.event.byId(id).upload((p0, p1) {});
        return;
      }
      await downloadEvent();
      await d2repository.trackerModule.event.upload((p0, p1) {});
    } catch (e) {
      snackBar(e.toString(), Colors.redAccent, Colors.black);
    }
  }

  static Future<void> downloadEvent({String? id}) async {
    try {
      if (id != null) {
        await d2repository.trackerModule.event.byId(id).download((p0, p1) {});
        return;
      }
      await d2repository.trackerModule.event.download((p0, p1) {});
    } catch (e) {
      snackBar(e.toString(), Colors.redAccent, Colors.black);
    }
  }

  static getSummary(TrackedEntityInstanceImportSummary? summary) {
    if (summary != null && summary.status == ImportStatus.Error) {
      String message = summary.conflicts!.isNotEmpty
          ? summary.conflicts?.map((conflict) => conflict.value).join(',')
          : summary.responseSummary['description'] ?? '';
      snackBar(message, Colors.redAccent, Colors.black);
    }
  }

  static void noInternetWarning() {
    AppHelpers.snackBar('You have no active internet connection',
        Colors.orangeAccent, Colors.black);
  }

  // static Future<PackageInfo> getAppInfo() async {
  //   return await PackageInfo.fromPlatform();
  // }

  // static getVersionDetails({Color? textColor}) {
  //   return FutureBuilder(
  //       future: getAppInfo(),
  //       builder: (context, snapshot) =>
  //           snapshot.hasData && snapshot.data != null
  //               ? Text(
  //                   snapshot.data!.version,
  //                   style: TextStyle(
  //                       overflow: TextOverflow.ellipsis,
  //                       fontSize: 10,
  //                       color: textColor ?? AppColors.bgMuted),
  //                 )
  //               : const Text(
  //                   '',
  //                 ));
  // }

  static getLogoutAlert() async {
    return await Get.dialog(
            AlertDialog(
              alignment: Alignment.center,
              insetPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.warning),
                label: const Text(
                  'Warning',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                style: ButtonStyle(
                    iconColor:
                        MaterialStateProperty.all<Color>(Colors.redAccent)),
              ),
              content: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: Get.height * 0.1, maxWidth: Get.width * 0.7),
                  child: const Center(
                    child: Text('You are about to logout. Are you sure?.'),
                  )),
              actions: <Widget>[
                Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 5, left: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.grey)),
                            onPressed: () {
                              Get.back(result: false);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {
                              Get.back(result: true);
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            barrierDismissible: false)
        .then((value) async {
      return value;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  static Future<bool> inforDialog({
    String? title,
    required String message,
    IconData? icon,
    Color? iconColor,
    bool warning = false,
  }) async {
    return await Get.dialog(
            AlertDialog(
              alignment: Alignment.center,
              insetPadding: EdgeInsets.zero,
              title: Text(
                title ?? 'Localization Permision',
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
              ),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: Get.height * 0.15,
                  maxWidth: Get.width * 0.7,
                ),
                child: Column(
                  children: [
                    if (warning && icon == null)
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Lottie.asset("images/lottie/warning.json",
                            fit: BoxFit.cover),
                      ),
                    if (icon != null)
                      Icon(
                        icon,
                        color: iconColor ?? Colors.blueAccent,
                        size: 100,
                      ),
                    Expanded(
                      child: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back(result: false);
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back(result: true);
                      },
                      child: Text(
                        'ACCEPT',
                        style: TextStyle(
                          color: warning ? Colors.redAccent : Colors.blueAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            barrierDismissible: false)
        .then((value) async {
      return value;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  // static Future<Position?> getLocation(String message) async {
  //   try {
  //     bool getLocation = await inforDialog(message: message);
  //     if (getLocation) {
  //       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //       if (!serviceEnabled) {
  //         AppHelpers.snackBar(
  //             'Location services are disabled. Please enable the services',
  //             Colors.redAccent,
  //             Colors.black);
  //         return null;
  //       }

  //       LocationPermission permission = await Geolocator.checkPermission();
  //       if (permission == LocationPermission.denied) {
  //         permission = await Geolocator.requestPermission();
  //         if (permission == LocationPermission.denied) {
  //           AppHelpers.snackBar('Location permissions are denied',
  //               Colors.redAccent, Colors.black);
  //           return null;
  //         }

  //         if (permission == LocationPermission.deniedForever) {
  //           AppHelpers.snackBar(
  //               'Location permissions are permanently denied, we cannot request permissions.',
  //               Colors.redAccent,
  //               Colors.black);
  //           return null;
  //         }

  //         return await Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.high);
  //       }

  //       return await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //     }

  //     return null;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  static showNoReservedValuesAttribute(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            children: [
              SimpleDialogOption(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.amber,
                  )
                ],
              )),
              SimpleDialogOption(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    "Could not open form, the app has run out of reserved Ids. Please redownload metadata or relogin before opening the form",
                    maxLines: 5,
                  ))
                ],
              ))
            ],
          );
        });
  }
}

extension StringExtension on String {
  String toSentenceCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Menu {
  final List<String> menuItems;
  String section;
  bool forMobile;
  String icon;
  List<String> authorities;
  String id;

  Menu(
      {required this.menuItems,
      required this.section,
      required this.forMobile,
      required this.icon,
      required this.authorities,
      required this.id});
}

class DisabledList {
  String? disabled;
  DisabledList({this.disabled});
}

class Arguments {
  final String name;
  final String filter;
  Arguments({
    required this.name,
    required this.filter,
  });
}
