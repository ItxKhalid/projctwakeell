import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    // You can use your preferred method to get the UID here
    currentUserUID =  FirebaseAuth.instance.currentUser!.uid;
    print('my id is $currentUserUID');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Clients'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('ClientsData')
            .where('lawerUID', isEqualTo: currentUserUID)
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
                return Card(
                  child: ListTile(
                    title: Text(clientData['ClientfullName']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Case Type: ${clientData['ClientcaseType']}'),
                        Text('Case Description: ${clientData['ClientcaseDetails']}'),
                        Text('Client Phone Number: ${clientData['ClientcontactNumber']}'),
                      ],
                    ),
                  ),
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
