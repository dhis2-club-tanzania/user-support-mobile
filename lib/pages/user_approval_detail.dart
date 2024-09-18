import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:user_support_mobile/pages/user_approval_select.dart';

import '../models/approve_model.dart';
import '../providers/provider.dart';
import 'package:user_support_mobile/constants/d2-repository.dart';

class UserApprovalDetailPage extends StatefulWidget {
  const UserApprovalDetailPage({Key? key, required this.userApproval, required this.userPayload})
      : super(key: key);
  final UserModel userApproval;
  final List<Userpayload>? userPayload;

  @override
  UserApprovalDetailPageState createState() => UserApprovalDetailPageState();
}

class UserApprovalDetailPageState extends State<UserApprovalDetailPage> {
  List<dynamic> _parseMessages() {
    return _addAccountData(widget.userApproval);
  }

  List<dynamic> _addAccountData(UserModel? userModel) {
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

  String _getDataEntryAccessLevel(Userpayload payload) {
    final organisationUnitNames = payload.organisationUnits
        ?.map((unit) => unit.name)
        .toList() ?? [];

    final childrenNames = payload.organisationUnits
        ?.expand((unit) => unit.children?.map((child) => child.name) ?? <String>[])
        .toList() ?? [];

    return [...organisationUnitNames, ...childrenNames].join(', ');
  }

  String _getReportAccessLevel(Userpayload payload) {
    final dataViewOrganisationUnitNames = payload.dataViewOrganisationUnits
        ?.map((unit) => unit.name)
        .toList() ?? [];

    final childrenNames = payload.dataViewOrganisationUnits
        ?.expand((unit) => unit.children?.map((child) => child.name) ?? <String>[])
        .toList() ?? [];

    return [...dataViewOrganisationUnitNames, ...childrenNames].join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContent(
        userApproval: widget.userApproval,
        userPayload: widget.userPayload,
        parseMessages: _parseMessages,
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  const PageContent({Key? key, required this.userApproval, this.userPayload, this.parseMessages}) : super(key: key);
  final UserModel userApproval;
  final List<Userpayload>? userPayload;
  final List<dynamic> Function()? parseMessages;

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  File? file;
  late UserModel userApproval;
  List<Userpayload>? userPayload;
  String? selectedUser;
  bool isVisible = true;
  bool isButtonEnabled = false;
  final TextEditingController _textEditingController = TextEditingController();
  bool _isDropdownShown = false;
  Color _selectButtonColor = Color(0xFF235EA0);
  bool _showDuplicatesButton = false;
  List<dynamic> _potentialDuplicates = [];
  bool _isLoading = false;



  @override
  void initState() {
    super.initState();
    userApproval = widget.userApproval;
    userPayload = widget.userPayload;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        SizedBox(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () async {
                  context.go('/home/user_account');
                },
              ),
            ),
            body: SafeArea(
              child: Center(
                child: Container(
                  height: size.height,
                  width: size.width * 0.9,
                  child: ListView(
                    children: [
                      Html(
                        data: widget.userApproval.message?.subject?.split("-").last ?? '',
                        style: {
                          'body': Style(
                            color: Colors.black,
                            fontSize: FontSize(16),
                            fontWeight: FontWeight.w300,
                          ),
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Html(
                        data: widget.userApproval.message?.message?.replaceAll('\n', '<br>') ?? '',
                        style: {
                          'body': Style(
                            color: Colors.black,
                            fontSize: FontSize(16),
                            fontWeight: FontWeight.w300,
                          ),
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        child: Row(
                          children: [
                            AbsorbPointer(
                              absorbing: _isDropdownShown,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    _selectButtonColor,
                                  ),
                                ),
                                onPressed: () {
                                  if (widget.userApproval.type == null) {
                                    final accounts = widget.parseMessages?.call() ?? [];
                                    // Navigate to the new dialog page and pass the accounts list
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ApprovalTableDialogPage(
                                          accounts: accounts,
                                          userApproval: widget.userApproval, userPayload: [],
                                        ),
                                      ),
                                    );
                                  } else if (widget.userApproval.type == "deactivate" || widget.userApproval.type == "activate"){
                                    context.read<MessageModel>().approvalActRequest(widget.userApproval);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            AbsorbPointer(
                              absorbing: false,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red),
                                ),
                                onPressed: () {
                                  if (userApproval.userPayload != null && userApproval.userPayload!.isNotEmpty) {
                                    _rejectAllPayloads(context, userApproval.userPayload!);
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Reject ALL',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _rejectAllPayloads(BuildContext context, List<Userpayload> payloads) async{
      var payload = payloads[0];
      showDataAlert(context, payload, true);
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
                          ? 'Are you sure you want to reject the of ALL request?'
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

}


String extractPlainText(String htmlContent) {
  final document = html_parser.parse(htmlContent);
  return document.body?.text ?? '';
}