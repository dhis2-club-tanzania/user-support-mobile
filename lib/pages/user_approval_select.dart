import 'package:flutter/material.dart';
import 'package:user_support_mobile/pages/ShowDropdownPage.dart';
import '../models/approve_model.dart';
import '../pages/user_approval_detail.dart';

class ApprovalTableDialogPage extends StatefulWidget {
  final List<dynamic> accounts;
  final UserModel userApproval;
  final List<Userpayload>? userPayload;

  const ApprovalTableDialogPage({
    Key? key,
    required this.accounts,
    required this.userApproval,
    required this.userPayload,
  }) : super(key: key);

  @override
  State<ApprovalTableDialogPage> createState() => _ApprovalTableDialogPageState();
}

class _ApprovalTableDialogPageState extends State<ApprovalTableDialogPage> {
  late UserModel userApproval;
  List<Userpayload>? userPayload;

  @override
  void initState() {
    super.initState();
    userApproval = widget.userApproval;
    userPayload = widget.userPayload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              'Select Account for Action',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),

            Expanded(
              child: ListView.builder(
                itemCount: widget.accounts.length,
                itemBuilder: (context, index) {
                  final account = widget.accounts[index];
                  final payloadStatus = account['payloadStatus'];
                  Color? rowColor;

                  if (payloadStatus == 'CREATED') {
                    rowColor = Colors.green.withOpacity(0.5);
                  } else if (payloadStatus == 'REJECTED') {
                    rowColor = Colors.red.withOpacity(0.5);
                  } else {
                    rowColor = Colors.white;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      color: rowColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          '${account['SN'] ?? ''} : ${account['Names'] ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black87,
                          ),
                        ),
                        children: [
                          _buildDetailRow('Email', account['Email']),
                          _buildDetailRow('Phone Number', account['Phone Number']),
                          _buildDetailRow('Entry Access Level', account['Entry Access Level']),
                          _buildDetailRow('Report Access Level', account['Report Access Level']),
                          SizedBox(height: 12.0),
                          _buildActionButton(account, payloadStatus),
                          SizedBox(height: 9.0),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(dynamic account, String? payloadStatus) {
    if (payloadStatus == 'CREATED') {
      return Text(
        'Created',
        style: TextStyle(
            color: const Color.fromARGB(255, 6, 84, 9),
            fontWeight: FontWeight.bold,
            fontSize: 19
        ),
      );
    } else if (payloadStatus == 'REJECTED') {
      return Text(
        'Rejected',
        style: TextStyle(
            color: const Color.fromARGB(255, 123, 15, 8),
            fontWeight: FontWeight.bold,
            fontSize: 19
        ),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
          backgroundColor: Colors.blueAccent,
        ),
        onPressed: () {
          final nameParts = (account['Names'] ?? '').split(' ');
          final firstName = nameParts.isNotEmpty ? nameParts[0] : '';
          final lastName = nameParts.length > 1 ? nameParts[1] : '';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowDropdownPage(
                firstName: firstName,
                lastName: lastName,
                userApproval: widget.userApproval,
                userPayload: widget.userPayload,
              ),
            ),
          );
        },
        child: Text(
          'Select',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}