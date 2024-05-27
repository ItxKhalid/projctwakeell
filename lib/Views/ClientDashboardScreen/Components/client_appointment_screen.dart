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
            PasAppointmenttScreen(),
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
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('userId', isEqualTo: currentUserUID).where('startDate', isGreaterThanOrEqualTo: currentDate)
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
                            Text('Title: ${clientData['title']}'),
                            Text('started at : ${clientData['startDate']} to ${clientData['endDate']}'),
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
          child: Text('No Appointments found.'),
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
  String getFormattedDate(DateTime dateTime) {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }
}



////
class PasAppointmenttScreen extends StatefulWidget {
  const PasAppointmenttScreen({super.key});

  @override
  State<PasAppointmenttScreen> createState() => _PasAppointmenttScreenState();
}

class _PasAppointmenttScreenState extends State<PasAppointmenttScreen> {
  late String currentUserUID;
  @override
  void initState() {
    super.initState();
    // Get the current user's UID
    currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('userId', isEqualTo: currentUserUID).where('endDate', isLessThan: currentDate)
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
                            Text('Title: ${clientData['title']}'),
                            Text('started at : ${clientData['startDate']} to ${clientData['endDate']}'),
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
          child: Text('No Appointments found.'),
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
  String getFormattedDate(DateTime dateTime) {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }
}
