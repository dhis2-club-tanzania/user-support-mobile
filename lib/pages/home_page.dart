import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/request.dart';
import '../controller/controllers.dart';
import '../constants/constants.dart';
import '../constants/d2-repository.dart';

import 'organisation_unit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                // Handle logout
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform logout actions
                            Navigator.of(context).pop();
                            // Navigate to login or perform any other actions
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              } else if (value == 'changeLevel') {
                // Handle change level
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String selectedLevel = 'Facility';
                    return AlertDialog(
                      title: Text('Change Level'),
                      content: DropdownButton<String>(
                        value: selectedLevel,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            // Handle the change of level
                            print("something has been changed");
                            setState(() {
                              selectedLevel = newValue;
                            });
                          }
                        },
                        items: <String>[
                          'Facility',
                          'District',
                          'Regions',
                          'National',
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Perform change level actions
                            print('Selected Level: $selectedLevel');
                            Navigator.of(context).pop();
                            // Implement logic for changing level
                          },
                          child: Text('Change Level'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'changeLevel',
                child: ListTile(
                  leading: Icon(Icons.arrow_upward),
                  title: Text('Change Level'),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: MyListView(
        sections: menuItems,
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  final List<Map<String, dynamic>> sections;

  MyListView({required this.sections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sections.length,
      itemBuilder: (context, sectionIndex) {
        String sectionName = sections[sectionIndex]['name'];
        List<Map<String, dynamic>> items =
            List.castFrom(sections[sectionIndex]['items']);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sectionName,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: MyWrapView(items: items),
            ),
          ],
        );
      },
    );
  }
}

class MyWrapView extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  MyWrapView({required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: List.generate(
        items.length,
        (index) => GestureDetector(
          onTap: () {
            print('${items[index]['name']} clicked');
            getRoute(items[index]['name']);
          },
          child: Column(
            children: [
              Container(
                height: 110,
                width: 110,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(items[index]['icon'],
                        size: 35, color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  items[index]['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getRoute(String item) {
    if (item.contains("Organisation")) Get.to(() => OrgUnitPage());
  }

  getData() async {
    // key from a namespace
    final res =
        await d2repository.httpClient.get('dataStore/dhis2-user-support');
    print(jsonEncode(res.body));

    // org unit level

    // org unit

    // datasets

    // programs

    return null;
  }
}
