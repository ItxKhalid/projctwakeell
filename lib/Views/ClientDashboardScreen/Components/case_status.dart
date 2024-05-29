import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/custom_Container_button.dart';

class CaseStatusScreen extends StatefulWidget {
  CaseStatusScreen({Key? key}) : super(key: key);

  @override
  _CaseStatusScreenState createState() => _CaseStatusScreenState();
}

class _CaseStatusScreenState extends State<CaseStatusScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String currentUserUID;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  }
  // To store the current user's UID

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Status'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: null,
          builder: (context, AsyncSnapshot<DocumentSnapshot>snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                      height: 8
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.teal, width: 1)),
                    child: TabBar(
                      controller: _tabController,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 11),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                      indicator: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelColor: Colors.white,
                      indicatorColor: Colors.black,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      ),
                      unselectedLabelColor: Colors.teal,
                      tabs: const [
                        Tab(
                          text: 'Pending',
                        ),
                        Tab(
                          text: 'In Progress',
                        ),
                        Tab(
                          text: 'Completed',
                        ),
                        Tab(
                          text: 'Cancelled',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children:  [
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('ClientsData')
                              .where('Client_Id', isEqualTo: currentUserUID)
                              .where('status', isEqualTo: "")
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
                                      title: Text(clientData['ClientfullName'], style: const TextStyle(color: Colors.teal)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Case Type: ${clientData['ClientcaseType']}'),
                                          Text('Case Description: ${clientData['ClientcaseDetails']}'),
                                          Text('Client Phone Number: ${clientData['ClientcontactNumber']}'),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: Text('No Case found.'),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('ClientsData')
                              .where('Client_Id', isEqualTo: currentUserUID)
                              .where('status', isEqualTo: "InProgress")
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
                                      title: Text(clientData['ClientfullName'], style: const TextStyle(color: Colors.teal)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Case Type: ${clientData['ClientcaseType']}'),
                                          Text('Case Description: ${clientData['ClientcaseDetails']}'),
                                          Text('Client Phone Number: ${clientData['ClientcontactNumber']}'),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: Text('No Case found.'),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('ClientsData')
                              .where('Client_Id', isEqualTo: currentUserUID)
                              .where('status', isEqualTo: "Completed")
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
                                      title: Text(clientData['ClientfullName'], style: const TextStyle(color: Colors.teal)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Case Type: ${clientData['ClientcaseType']}'),
                                          Text('Case Description: ${clientData['ClientcaseDetails']}'),
                                          Text('Client Phone Number: ${clientData['ClientcontactNumber']}'),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: Text('No Case found.'),
                            );
                          },
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('ClientsData')
                              .where('Client_Id', isEqualTo: currentUserUID)
                              .where('status', isEqualTo: "Cancelled")
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
                                      title: Text(clientData['ClientfullName'], style: const TextStyle(color: Colors.teal)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Case Type: ${clientData['ClientcaseType']}'),
                                          Text('Case Description: ${clientData['ClientcaseDetails']}'),
                                          Text('Client Phone Number: ${clientData['ClientcontactNumber']}'),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            return const Center(
                              child: Text('No Case found.'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
