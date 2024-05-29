import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projctwakeell/Widgets/custom_Container_button.dart';
import '../../../Utils/images.dart';

class MyClientScreens extends StatefulWidget {
  const MyClientScreens({Key? key});

  @override
  State<MyClientScreens> createState() => _MyClientScreensState();
}

class _MyClientScreensState extends State<MyClientScreens> {
  late String currentUserUID; // To store the current user's UID

  @override
  void initState() {
    super.initState();
    // Get the current user's UID from Firebase Authentication
    currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    print('my id is $currentUserUID');
  }

  Future<void> updateCaseStatus(String clientId, String newStatus) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: AppConst.spinKitWave());
        },
        barrierDismissible: false,
      );
      await FirebaseFirestore.instance
          .collection('ClientsData')
          .doc(clientId)
          .update({'status': newStatus});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Case status updated to $newStatus')),
      );
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Clients'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ClientsData')
            .where('lawyerUid', isEqualTo: currentUserUID)
            .where('status', whereIn: ["", "InProgress"]) // Include both empty and "In Progress" statuses
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var clientData = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(clientData['ClientfullName'], style: const TextStyle(color: Colors.teal)),
                        Text(clientData['status']+'...', style: const TextStyle(color: Colors.teal)),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Case Type: ${clientData['ClientcaseType']}'),
                        Text('Case Description: ${clientData['ClientcaseDetails']}'),
                        Text('Client Phone Number: ${clientData['ClientcontactNumber']}'),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (clientData['status'] != 'InProgress')
                              CustomButton(
                                borderRadius: BorderRadius.circular(8),
                                height: 30,
                                width: 90,
                                border: Border.all(color: Colors.teal),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'fontFamily',
                                fontSize: 12,
                                text: 'In Progress',
                                color: Colors.teal,
                                onTap: () {
                                  updateCaseStatus(clientData.id, 'InProgress');
                                },
                              ),
                            CustomButton(
                              borderRadius: BorderRadius.circular(8),
                              height: 30,
                              width: 90,
                              border: Border.all(color: Colors.teal),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'fontFamily',
                              fontSize: 12,
                              text: 'Cancel Case',
                              color: Colors.teal,
                              onTap: () {
                                updateCaseStatus(clientData.id, 'Cancelled');
                              },
                            ),
                            CustomButton(
                              borderRadius: BorderRadius.circular(8),
                              height: 30,
                              width: 90,
                              backgroundColor: Colors.teal,
                              border: Border.all(color: Colors.teal),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'fontFamily',
                              fontSize: 12,
                              text: 'Complete Case',
                              color: Colors.white,
                              onTap: () {
                                updateCaseStatus(clientData.id, 'Completed');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('No clients found.'),
          );
        },
      ),
    );
  }
}
