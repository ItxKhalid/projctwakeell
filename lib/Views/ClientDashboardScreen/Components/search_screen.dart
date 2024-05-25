import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../../service/Userclass.dart';
import '../../../service/chat_room_model.dart';
import 'client_message_screen.dart';

var uuid = const Uuid();

class SearchScreen extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  final UserModel loggedInUser;

  const SearchScreen({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
    required this.loggedInUser,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("chatRooms")
        .where("participants.${widget.userModel?.userId}", isEqualTo: true)
        .where("participants.${targetUser.userId}", isEqualTo: true)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      log("ChatRoomModel found");
      var data = querySnapshot.docs[0].data();
      return ChatRoomModel.fromMap(data as Map<String, dynamic>);
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
        chatRoomId: uuid.v1(),
        lastMessage: "",
        participants: {
          widget.userModel?.userId.toString(): true,
          targetUser.userId: true,
        },
      );

      await FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap())
          .whenComplete(() => log("New chat room created"));

      return newChatRoom;
    }
  }

  Future<dynamic> toChatRoom(BuildContext context, UserModel searchedUser, ChatRoomModel chatRoomModel) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ClientMessageScreen(
          firebaseUser: widget.firebaseUser,
          targetUser: searchedUser,
          userModel: widget.userModel!,
          chatRoom: chatRoomModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Clients'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by first name',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("lawyer")
                  .where("firstName", isGreaterThanOrEqualTo: searchController.text)
                  .where("firstName", isLessThan: searchController.text + 'z')
                  .where("firstName", isNotEqualTo: widget.userModel?.firstName)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Results Found"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      UserModel searchedUser = UserModel.fromMap(document.data() as Map<String, dynamic>);
                      return ListTile(
                        onTap: () async {
                          ChatRoomModel? chatRoom = await getChatRoomModel(searchedUser);
                          if (chatRoom != null) {
                            await toChatRoom(context, searchedUser, chatRoom);
                          }
                        },
                        leading: Hero(
                          tag: searchedUser.firstName.toString(),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/image11.png'),
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_right),
                        title: Text(searchedUser.firstName.toString()),
                        subtitle: Text(searchedUser.lastName.toString()),
                      );
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
}
