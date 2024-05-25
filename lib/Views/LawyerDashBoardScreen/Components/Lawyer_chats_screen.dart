import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'Add_client_details.dart';
import 'Lawyer_message_screen.dart';

class LawyerChatsScreen extends StatefulWidget {
  const LawyerChatsScreen({Key? key});

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

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('client')
        .where('firstName', isGreaterThanOrEqualTo: query)
        .where('firstName', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    setState(() {
      searchResults = querySnapshot.docs;
    });
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
            child: searchResults.isEmpty
                ? Center(
              child: Text(
                'No clients found',
                style: TextStyle(fontSize: 18.0),
              ),
            )
                : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var clientData =
                searchResults[index].data() as Map<String, dynamic>;
                return _buildChatItem(clientData);
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
    String timestamp = clientData['timestamp'] ?? 'No timestamp';

    return GestureDetector(
      onTap: () {
        // Navigate to chat page and pass client name
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LawyerMessageScreen(clientName: name),
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
                  timestamp,
                  style: TextStyle(
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
