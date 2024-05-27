import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'Add_client_details.dart';
import 'Lawyer_message_screen.dart';

class LawyerChatsScreen extends StatefulWidget {
  const LawyerChatsScreen({Key? key}) : super(key: key);

  @override
  State<LawyerChatsScreen> createState() => _LawyerChatsScreenState();
}

class _LawyerChatsScreenState extends State<LawyerChatsScreen> {
  List<DocumentSnapshot> searchResults = [];
  TextEditingController searchController = TextEditingController();

  Future<void> searchClients(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    // Combine search for firstName and lastName
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('client')
        .where('firstName', isGreaterThanOrEqualTo: query)
        .where('firstName', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      searchResults = querySnapshot.docs;
    });
  }
  ///set RoomId for one to one chat
  String chatRoomId(String user1, String user2) {
    if (user1.isEmpty || user2.isEmpty) {
      // Handle empty strings as needed, e.g., return a default value
      return 'defaultRoomId';
    }

    // Make sure both strings are in lowercase before creating the ID
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Chats'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
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
                        SizedBox(width: 8.0),
                        Icon(Icons.search, color: AppColors.tealB3),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            cursorColor: AppColors.tealB3,
                            decoration: InputDecoration(
                              hintText: 'Search client',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.black),
                            onChanged: (value) {
                              searchClients(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddClientScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.add_circle_outline,
                            color: AppColors.tealB3, size: 40.0),
                      ),
                    ],
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('client').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No clients found'));
                } else {
                  searchResults = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      var clientData = searchResults[index].data() as Map<String, dynamic>;
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
    String lastMessage = clientData['lastMessage'] ?? 'No message';
    Timestamp timestamp = clientData['timestamp'] ?? Timestamp.now();
    String formattedTimestamp = DateFormat('MM/dd/yyyy, hh:mm a').format(timestamp.toDate());
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String roomId = chatRoomId(uid,clientData['userId']);
    return GestureDetector(
      onTap: () {
        // Navigate to chat page and pass client name
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LawyerMessageScreen(clientName: name,clientId: clientData['userId'],chatRoomId: roomId),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0, left: 16.0, right: 16.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 4),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/image11.png'),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    lastMessage,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
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
