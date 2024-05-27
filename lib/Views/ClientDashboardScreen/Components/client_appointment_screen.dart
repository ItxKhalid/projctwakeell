import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';// Import the upcoming screen

class ClientAppointmentScreen extends StatefulWidget {
  const ClientAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<ClientAppointmentScreen> createState() => _ClientAppointmentScreenState();
}

class _ClientAppointmentScreenState extends State<ClientAppointmentScreen> with TickerProviderStateMixin {
  late String currentUserUID;

  @override
  void initState() {
    super.initState();
    // Get the current user's UID
    currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Upcoming', icon: Icon(Icons.new_label_rounded)),
              Tab(text: 'Past', icon: Icon(Icons.paste)),
              Tab(text: 'Cancelled', icon: Icon(Icons.cancel)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Upcoming appointments screen
            ClientUpcomingScreen(),
            // Past appointments screen
            FutureBuilder(
              future: getPastAppointments(),
              builder: (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No past appointments found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var appointment = snapshot.data![index];
                      return ListTile(
                        title: Text(appointment['title']),
                        subtitle: Text('Date: ${appointment['startDate']}'),
                        // You can display more details as needed
                      );
                    },
                  );
                }
              },
            ),
            // Cancelled appointments screen
            Container(
              child: Center(
                child: Text('Cancelled Appointments'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<QueryDocumentSnapshot>> getPastAppointments() async {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    var querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: currentUserUID)
        .where('endDate', isLessThan: formattedDate)
        .get();

    return querySnapshot.docs;
  }
}

class ClientUpcomingScreen extends StatefulWidget {
  const ClientUpcomingScreen({Key? key}) : super(key: key);

  @override
  _ClientUpcomingScreenState createState() => _ClientUpcomingScreenState();
}

class _ClientUpcomingScreenState extends State<ClientUpcomingScreen> {
  late String currentUserUID;

  @override
  void initState() {
    super.initState();
    // Get the current user's UID
    currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('userId', isEqualTo: currentUserUID)
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
          // Store lawyer IDs to avoid duplicates

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var clientData = snapshot.data!.docs[index];
              String lawyerId = clientData['lawyerId'];
              // Check if lawyer ID is unique, if not, skip// Add lawyer ID to the set
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
                        title: Text(lawyerData['firstName'] + " " + lawyerData['lastName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gender: ${lawyerData['gender']}'),
                            Text('Phone Number: ${lawyerData['phoneNumber']}'),
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
    );
  }

  Future<List<DocumentSnapshot>> getUpcomingAppointments() async {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    var querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: currentUserUID)
        .where('startDate', isGreaterThanOrEqualTo: formattedDate)
        .get();

    return querySnapshot.docs;
  }
}
