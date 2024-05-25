import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../../../service/Userclass.dart';
import '../../../service/chat_room_model.dart';
import '../../../service/firebase_helper.dart';
import 'client_message_screen.dart';
import 'search_screen.dart';

class ClientChatsScreen extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  final UserModel loggedInUser;


  const ClientChatsScreen({Key? key, required this.userModel, required this.firebaseUser, required this.loggedInUser})
      : super(key: key);

  @override
  State<ClientChatsScreen> createState() => _ClientChatsScreenState();
}

class _ClientChatsScreenState extends State<ClientChatsScreen> {
  List<DocumentSnapshot> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    UserModel loggedInUser = widget.loggedInUser;

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
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search messages',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('chatRooms')
                  .where('participants.${widget.userModel?.userId}', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No messages yet',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  );
                }

                var chatRoomDocs = snapshot.data!.docs;

                // Filter chat rooms based on search query
                if (searchController.text.isNotEmpty) {
                  chatRoomDocs = chatRoomDocs.where((doc) {
                    var chatRoomData = doc.data() as Map<String, dynamic>;
                    return (chatRoomData['lastMessage'] as String)
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());
                  }).toList();
                }

                return ListView.builder(
                  itemCount: chatRoomDocs.length,
                  itemBuilder: (context, index) {
                    var chatRoomData = chatRoomDocs[index].data() as Map<String, dynamic>;
                    return _buildChatRoomItem(chatRoomDocs[index].id, chatRoomData);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(
                userModel: widget.userModel,
                firebaseUser: widget.firebaseUser, loggedInUser: loggedInUser,
              ),
            ),
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }

  Widget _buildChatRoomItem(String chatRoomId, Map<String, dynamic> chatRoomData) {
    ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(chatRoomData);
    Map<String?, dynamic>? participants = chatRoomModel.participants;
    List<String?> participantsKeys = participants!.keys.where((element) => element != widget.userModel?.userId).toList();

    return FutureBuilder(
      future: FirebaseHelper.getUserModelById(participantsKeys[0]),
      builder: (context, data) {
        if (data.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (data.hasError) {
          return Center(child: Text("Error: ${data.error}"));
        } else if (!data.hasData) {
          return const Center(child: Text("User not found"));
        } else {
          UserModel targetUser = data.data as UserModel;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClientMessageScreen(
                    firebaseUser: widget.firebaseUser,
                    targetUser: targetUser,
                    userModel: widget.userModel!,
                    chatRoom: chatRoomModel,
                  ),
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
                    child: CircleAvatar(
                      // Assuming userDpUrl is a non-null String
                     // backgroundImage: NetworkImage(targetUser.userDpUrl ?? 'assets/images/image11.png'),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          targetUser.firstName!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          chatRoomModel.lastMessage ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
