import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'Lawyer_message_screen.dart';

class LawyerChatsScreen extends StatefulWidget {
  const LawyerChatsScreen({Key? key}) : super(key: key);

  @override
  State<LawyerChatsScreen> createState() => _LawyerChatsScreenState();
}

class _LawyerChatsScreenState extends State<LawyerChatsScreen> {
  List<DocumentSnapshot> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  Future<void> searchClients(String query) async {
    if (query.isEmpty) {
      setState(() {
        isSearching = false;
        searchResults = [];
      });
      return;
    }

    String lowercaseQuery = query.toLowerCase();

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('client')
        .where('firstName', isGreaterThanOrEqualTo: lowercaseQuery)
        .where('firstName', isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
        .get();

    QuerySnapshot querySnapshotLastName = await FirebaseFirestore.instance
        .collection('client')
        .where('lastName', isGreaterThanOrEqualTo: lowercaseQuery)
        .where('lastName', isLessThanOrEqualTo: lowercaseQuery + '\uf8ff')
        .get();

    setState(() {
      isSearching = true;
      searchResults = querySnapshot.docs + querySnapshotLastName.docs;
    });
  }

  /// Set RoomId for one-to-one chat
  String chatRoomId(String user1, String user2) {
    if (user1.isEmpty || user2.isEmpty) {
      return 'defaultRoomId';
    }

    user1 = user1.toLowerCase();
    user2 = user2.toLowerCase();

    if (user1[0].codeUnits[0] > user2[0].codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8.0),
                        Icon(Icons.search, color: AppColors.tealB3),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            cursorColor: AppColors.tealB3,
                            decoration: const InputDecoration(
                              hintText: 'Search client',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) {
                              searchClients(value);
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              isSearching = false;
                              searchResults = [];
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Messages',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isSearching
                ? ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var clientData = searchResults[index].data() as Map<String, dynamic>;
                return _buildChatItem(clientData);
              },
            )
                : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('client').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No client found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var clientData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      return _buildChatItem(clientData);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> clientData) {
    String firstName = clientData['firstName'] ?? '';
    String lastName = clientData['lastName'] ?? '';
    String name = '$firstName $lastName'.trim();
    Timestamp timestamp = clientData['timestamp'] ?? Timestamp.now();
    String formattedTimestamp = DateFormat('MM/dd/yyyy, hh:mm a').format(timestamp.toDate());
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String roomId = chatRoomId(uid, clientData['userId']);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LawyerMessageScreen(
              clientName: name,
              clientId: clientData['userId'],
              chatRoomId: roomId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0, left: 16.0, right: 16.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/image11.png'),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedTimestamp,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
