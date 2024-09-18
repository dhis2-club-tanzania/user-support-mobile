// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:user_support_mobile/constants/d2-repository.dart';
import 'package:user_support_mobile/models/approve_model.dart';
import 'package:user_support_mobile/providers/provider.dart';

class ShowDropdownPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final UserModel userApproval;
  final List<Userpayload>? userPayload;


  ShowDropdownPage({
    required this.firstName,
    required this.lastName,
    required this.userApproval,
    this.userPayload,
  }) : super();


  @override
  _ShowDropdownPageState createState() => _ShowDropdownPageState();
}

class _ShowDropdownPageState extends State<ShowDropdownPage> {
  late String firstName;
  late String lastName;
  late UserModel userApproval;
  List<Userpayload>? userPayload;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _textEditingController = TextEditingController();
  late String _proposedUsername;
  late Userpayload _selectedPayload;
  List<dynamic> _potentialDuplicates = [];
  String? selectedUser;
  bool _showDuplicatesButton = false;


  @override
  void initState() {
    super.initState();
    userApproval = widget.userApproval;
    userPayload = widget.userPayload;
    firstName = widget.firstName;
    lastName = widget.lastName;
    _proposedUsername = _generateProposedUsername(widget.firstName, widget.lastName);
    _usernameController.text = _proposedUsername;
    _selectedPayload = widget.userApproval.userPayload!.firstWhere(
          (payload) => '${payload.firstName} ${payload.surname}' == '${widget.firstName} ${widget.lastName}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    String proposedUsername = _generateProposedUsername(firstName, lastName);
    var SelectedPayload = userApproval.userPayload!.firstWhere(
          (payloadu) => '${payloadu.firstName} ${payloadu.surname}' == '$firstName $lastName',);

    Future <bool> _checkExistingUsername(String username) async {
      String usernames = username.toLowerCase();
      EasyLoading.show(
        status: 'Checking for Existing Username...🔄',
        maskType: EasyLoadingMaskType.black,
      );
      final response = await d2repository.httpClient.get(
        'users?filter=userCredentials.username:eq:$usernames&fields=id',
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.body['users']??[0]??['id'].toList();
        if (data.isEmpty) {
          EasyLoading.showSuccess('No Existing Username found');
          return false;
        } else {
          EasyLoading.showSuccess('Existing Username found... Please Change the Username', dismissOnTap: true );
          usernameController.text = "";
          return true;
        }
      } else {

        _showMessage(context, "Error checking existing username.");
        return true;
      }
    }

    Future<bool> _checkDuplicate(UserModel userApproval, Userpayload SelectedPayload) async {
      EasyLoading.show(
        status: 'Performing Check...🔄 ',
        maskType: EasyLoadingMaskType.black,
      );
      if (userApproval.userPayload != null && userApproval.userPayload!.isNotEmpty) {
        String? email = SelectedPayload.email;
        String? phoneNumber = SelectedPayload.phoneNumber;
        String? userApprovalId = userApproval.id;

        if (email == null || phoneNumber == null || userApprovalId == null) {
          print("Email, PhoneNumber, or UserApprovalId is missing.");
          EasyLoading.showError('Missing Data.');
          return false;
        }

        try {
          print('Phone number query: $phoneNumber');
          print('Email query: $email');

          final emailResponse = await d2repository.httpClient.get(
              'users.json?filter=email:eq:$email&fields=id,firstName,surname,email,phoneNumber,userCredentials,disabled,createdBy[name],lastUpdatedBy[name],username,lastLogin,passwordLastUpdated,organisationUnits[id,name],dataViewOrganisationUnits[id,name]'
          );

          final phoneResponse = await d2repository.httpClient.get(
              'users.json?filter=phoneNumber:eq:$phoneNumber&fields=id,firstName,surname,email,phoneNumber,userCredentials,disabled,createdBy[name],lastUpdatedBy[name],username,lastLogin,passwordLastUpdated,organisationUnits[id,name],dataViewOrganisationUnits[id,name]'
          );

          dynamic emailResponseBody;
          if (emailResponse.body is String) {
            emailResponseBody = jsonDecode(emailResponse.body);
          } else {
            emailResponseBody = emailResponse.body;
          }

          dynamic phoneResponseBody;
          if (phoneResponse.body is String) {
            phoneResponseBody = jsonDecode(phoneResponse.body);
          } else {
            phoneResponseBody = phoneResponse.body;
          }

          if (emailResponseBody is! Map<String, dynamic> || phoneResponseBody is! Map<String, dynamic>) {
            print('Error: Response bodies are not maps');
            EasyLoading.showError('Invalid Response Format');
            return false;
          }

          if ((emailResponse.statusCode == 200 || emailResponse.statusCode == 304) &&
              (phoneResponse.statusCode == 200 || phoneResponse.statusCode == 304)) {

            final totalEmailUsers = emailResponseBody['pager']['total'];
            final totalPhoneUsers = phoneResponseBody['pager']['total'];

            print('Total Email Users Found: $totalEmailUsers');
            print('Total Phone Users Found: $totalPhoneUsers');

            List<dynamic> emailUsers = emailResponseBody['users'] ?? [];
            List<dynamic> phoneUsers = phoneResponseBody['users'] ?? [];

            print('Email Users: $emailUsers');
            print('Phone Users: $phoneUsers');

            bool isDuplicateEmail = emailUsers.any((user) => (user['id'] as String?) != userApprovalId);
            bool isDuplicatePhone = phoneUsers.any((user) => (user['id'] as String?) != userApprovalId);

            if (isDuplicateEmail || isDuplicatePhone) {
              _potentialDuplicates = [...emailUsers, ...phoneUsers];

              EasyLoading.showSuccess('Succeeded check!, duplicates were found');
              setState(() {
                _showDuplicatesButton = true;
              });
              return true;
            }

            EasyLoading.showSuccess('Succeeded check!, No duplicates found!');
            return false;
          } else {
            print('Failed to fetch user data for email or phone number');
            EasyLoading.showError('Failed to fetch user data');
            return false;
          }
        } catch (e, stackTrace) {
          print('An error occurred: $e');
          print('Stack trace: $stackTrace');
          EasyLoading.showError('Error during duplicate check');
          return false;
        } finally {
          EasyLoading.dismiss();
        }
      } else {
        print("No payload data available.");
        EasyLoading.showError('No payload data available.');
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details for $firstName $lastName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Proposed Username for User Account:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              '$proposedUsername',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Enter Username (Ensure five or more Characters)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool hasDuplicates = await _checkDuplicate(userApproval, SelectedPayload);
                setState(() {
                  _showDuplicatesButton = hasDuplicates;
                });
              },
              child: Text('Check Duplicate'),
            ),
            if (_showDuplicatesButton)... [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showPotentialDuplicatesPopup(context),
                child: Text('View Potential Duplicates'),
              ),],
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDataAlert(context, SelectedPayload, false);
                  },
                  child: Text('Reject'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool usernameExists = await _checkExistingUsername(usernameController.text);
                    if (!usernameExists){
                      _confirmUsername(context, usernameController.text, SelectedPayload);
                    }
                  },
                  child: Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _generateProposedUsername(String firstName, String lastName) {
    return firstName[0].toLowerCase() + lastName.toLowerCase();
  }

  Future<void> _confirmUsername(BuildContext context, String username, Userpayload SelectedPayload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to create a user with username $username?'),
          actions: [
            TextButton(
              onPressed: () {
                _createUser(username, SelectedPayload);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _showPotentialDuplicatesPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Potential Duplicates'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _potentialDuplicates.length,
                    itemBuilder: (context, index) {
                      final user = _potentialDuplicates[index];

                      return ExpansionTile(
                        title: Text('${(index + 1).toString()}: ${user['firstName'] ?? 'Unknown'} ${user['surname'] ?? 'Unknown'}'),
                        children: <Widget>[
                          ListTile(
                            title: Text('Phone Number:'),
                            subtitle: Text(user['phoneNumber'] ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Email:'),
                            subtitle: Text(user['email'] ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Data Entry:'),
                            subtitle: Text(user['dataEntry'] ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Reports:'),
                            subtitle: Text(user['reports'] ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Username:'),
                            subtitle: Text(user['username'] ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Last Login:'),
                            subtitle: Text(user['lastLogin'] ?? 'N/A'),
                          ),
                          ListTile(
                            title: Text('Password Last Updated:'),
                            subtitle: Text(user['passwordLastUpdated'] ?? 'N/A'),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future <void> _createUser(String username, Userpayload SelectedPayload, {bool isAccept = true}) async {
    SelectedPayload.username = username;
    SelectedPayload.password = "Hmis@2024";
    print('User created with username: ${SelectedPayload.username}');

    await _loading(isAccept, SelectedPayload);
    Navigator.of(context).pop();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future  <void> showDataAlert(BuildContext context, Userpayload SelectedPayload, bool isRejectAll, {bool isAccept = false}) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          content: Container(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _textEditingController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: isRejectAll? 'Provide a reason for rejection of ALL requests' : 'Provide a reason for rejection of request',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      isRejectAll
                          ? 'Are you sure you want to reject ALL request?'
                          : 'Are you sure you want to reject the request?',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text(isRejectAll ? 'Reject ALL' : 'Reject'),
              onPressed: () {
                if(isRejectAll == true){
                  userApproval.actionType = "REJECTED";
                  userApproval.status ="REJECTED";
                  userApproval.replyMessage = _textEditingController.text.trim();
                }
                else if(isRejectAll == false){
                  SelectedPayload.status = "REJECTED";
                  SelectedPayload.reason = _textEditingController.text.trim();
                  SelectedPayload.password = null;
                  SelectedPayload.username = null;
                  SelectedPayload.userCredentials!.username = null;
                }
                _loading(isAccept, SelectedPayload);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _loading(bool isAccept, Userpayload selectedPayload) async {
    EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
    String? name = '${selectedPayload.firstName} ${selectedPayload.surname}';

    try {
      await context.read<MessageModel>().approvalUserRequest(
        widget.userApproval,
        name,
        message: isAccept ? null : _textEditingController.text.trim(),
      );

      bool loading = context.read<MessageModel>().isLoading;

      if (!loading) {
        EasyLoading.showSuccess('Success!');
        context.pushReplacement('/home/user_account');
      }
    } catch (e) {
      EasyLoading.showError('Error: ${e.toString()}');
      context.pushReplacement('/home/user_account');
    } finally {
      EasyLoading.dismiss();
    }
  }
}