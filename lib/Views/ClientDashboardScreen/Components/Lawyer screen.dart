import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyLawyerScreens extends StatefulWidget {
  const MyLawyerScreens({Key? key});

  @override
  State<MyLawyerScreens> createState() => _MyLawyerScreensState();
}

class _MyLawyerScreensState extends State<MyLawyerScreens> {
  late String currentUserUID; // To store the current user's UID

  @override
  void initState() {
    super.initState();
    // Get the current user's UID from Firebase Authentication
    // You can use your preferred method to get the UID here
    currentUserUID =  FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Lawyer'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ClientsData')
            .where('Client_Id', isEqualTo: currentUserUID)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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
                String lawyerId = clientData['lawerUID'];
                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('lawyer')
                      .where('uid', isEqualTo: lawyerId)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> lawyerSnapshot) {
                    if (lawyerSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (lawyerSnapshot.hasError) {
                      return Text('Error: ${lawyerSnapshot.error}');
                    }
                    if (lawyerSnapshot.hasData && lawyerSnapshot.data!.docs.isNotEmpty) {
                      var lawyerData = lawyerSnapshot.data!.docs.first;
                      return Card(
                        child: ListTile(
                          title: Text(lawyerData['firstName']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${lawyerData['email']}'),
                              Text('Case Description: ${lawyerData['email']}'),
                              Text('Phone Number: ${lawyerData['phoneNumber']}'),
                              // Text('Lawyer: ${lawyerData['firstName']} ${lawyerData['lastName']}'),
                              Text('License Number: ${lawyerData['licenseNumber']}'),
                            ],
                          ),
                        ),
                      );
                    }
                    return Text('No lawyer found for this client');
                  },
                );
              },
            );
          }
          return Center(
            child: Text('No clients found.'),
          );
        },
      ),
    );
  }
}
