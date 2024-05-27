import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart'; // Add this for image picking
import 'package:uuid/uuid.dart';
import '../../../Utils/colors.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class LawyerMessageScreen extends StatefulWidget {
  final String clientName;
  final String clientId;
  final String chatRoomId;


  const LawyerMessageScreen({Key? key, required this.clientName, required this.chatRoomId,required this.clientId}) : super(key: key);

  @override
  State<LawyerMessageScreen> createState() => _LawyerMessageScreenState();
}

class _LawyerMessageScreenState extends State<LawyerMessageScreen> {
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  DatabaseReference _messagesRef = FirebaseDatabase.instance.reference().child('messages');
  String lawyerId = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        name: widget.clientName,
        imageassets: 'assets/images/image11.png',
        onPhonePressed: () {
          // Handle phone icon pressed
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DatabaseEvent>(
              stream: _messagesRef.onValue,
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return  Center(child: AppConst.spinKitWave());
                // }

                if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                  return const Center(child: Text('No messages yet'));
                }

                Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                List<Map<String, dynamic>> messages = [];
                data.forEach((key, value) {
                  var message = Map<String, dynamic>.from(value);
                  if ((message['senderId'] == lawyerId && message['receiverId'] == widget.clientId) ||
                      (message['senderId'] == widget.clientId && message['receiverId'] == lawyerId)) {
                    messages.add(message);
                  }
                });
                messages.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    var message = messages[index];
                    return _buildChatItem(message);
                  },
                );
              },
            ),
          ),
          _buildInputArea(themeProvider),
        ],
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> messageData) {
    bool isSentByUser = messageData['senderId'] == lawyerId;
    String message = messageData['message'] ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByUser)
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/image11.png'),
            ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: isSentByUser ? AppColors.tealB3 : Colors.grey[200],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isSentByUser ? Colors.white : AppColors.black,
                fontSize: 16.sp,
              ),
            ),
          ),
          if (isSentByUser)
            SizedBox(width: 8.w),
          if (isSentByUser)
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/image11.png'),
            ),
        ],
      ),
    );
  }

  Widget _buildInputArea(ThemeChangerProvider themeProvider) {
    String lawyerId = FirebaseAuth.instance.currentUser!.uid;
    var messageController = TextEditingController();
    final firestore.FirebaseFirestore _firestore = firestore.FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    File? imageFile;

    ///for audio
    @override
    void dispose() {
      _textEditingController.dispose();
      _scrollController.dispose();
      super.dispose();
    }

    ///For image



    Future uploadImage() async {
      String fileName = const Uuid().v1();
      int status = 1;

      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .set({
        "sendByUser": _auth.currentUser!.uid,
        "message": "",
        "type": "img",
        "time": firestore.FieldValue.serverTimestamp(),
      });

      var ref =
      FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

      var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
        await _firestore
            .collection('chatroom')
            .doc(widget.chatRoomId)
            .collection('chats')
            .doc(fileName)
            .delete();

        status = 0;
      });

      if (status == 1) {
        String imageUrl = await uploadTask.ref.getDownloadURL();

        await _firestore
            .collection('chatroom')
            .doc(widget.chatRoomId)
            .collection('chats')
            .doc(fileName)
            .update({"message": imageUrl});

        print(imageUrl);
      }
    }


    void onSendMessage() async {
      if (messageController.text.isNotEmpty) {
        // firestore.DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
        // String _auth.currentUser!.uid = userSnapshot['name'];
        Map<String, dynamic> messages = {
          "sendByUser": _auth.currentUser!.uid,
          "message": messageController.text,
          "type": "text",
          "time": firestore.FieldValue.serverTimestamp(),
        };

        messageController.clear();
        await _firestore
            .collection('chatroom')
            .doc(widget.chatRoomId)
            .collection('chats')
            .add(messages);
      } else {
        print("Enter Some Text");
      }
    }
    Future getImage() async {
      ImagePicker _picker = ImagePicker();

      await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
        if (xFile != null) {
          imageFile = File(xFile.path);
          uploadImage();
        }
      });
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.emoji_emotions, color: AppColors.tealB3, size: 28.sp),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingController,
                      cursorColor: AppColors.tealB3,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message',
                        hintStyle: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // await _sendImage();
                    },
                    icon: Icon(Icons.attach_file_rounded, color: AppColors.tealB3, size: 28.sp),
                  ),
                  IconButton(
                    onPressed: () => getImage(),
                    icon: Icon(Icons.camera_alt_rounded, color: AppColors.tealB3, size: 28.sp),
                  )
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: onSendMessage,
            shape: const CircleBorder(),
            color: AppColors.tealB3,
            padding: EdgeInsets.all(12.r),
            minWidth: 0,
            child: Icon(Icons.send, color: AppColors.white, size: 30.sp),
          )
        ],
      ),
    );
  }
}
