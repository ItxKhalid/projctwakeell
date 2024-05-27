import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart'; // Add this for image picking
import 'package:uuid/uuid.dart';
import '../../../Utils/colors.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../Widgets/massage_bubbels.dart';
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
  ScrollController _scrollController = ScrollController();
  String lawyerId = FirebaseAuth.instance.currentUser!.uid;
  final firestore.FirebaseFirestore _firestore = firestore.FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool scrollbool = false;

  double itemHeight = 50.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              child: StreamBuilder<firestore.QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(widget.chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<firestore.QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    if (_scrollController.hasClients) {
                      double maxScrollExtent =
                          _scrollController.position.maxScrollExtent;
                      double offset = _scrollController.offset;
                      double reversedOffset = maxScrollExtent - offset;
                      int bottomItemIndex =
                      (reversedOffset / itemHeight).ceil();

                      // print("----------------------current index          ${bottomItemIndex}--------------------------");
                      if (bottomItemIndex > 2) {
                        scrollbool = false;
                      } else {
                        scrollbool = true;
                      }
                    }

                    if (snapshot.data!.docs.length > 3 &&
                        scrollbool == true) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_scrollController.hasClients) {
                          _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent);
                        }
                      });
                      scrollbool = false;
                    }
                    return ListView.builder(
                      // controller: _scrollController,
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map, context);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            _buildInputArea(themeProvider),
          ],
        ),
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
      messageController.dispose();
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
                      controller: messageController,
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


  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return GestureDetector(

      onLongPress: () {
        showDeleteMessageDialog(context, _firestore
            .collection('chatroom')
            .doc(widget.chatRoomId)
            .collection('chats')
            .doc(map['id']));
      },
      child: map['type'] == "text"
          ? Container(
        width: size.width,
        alignment: map['sendByUser'] == _auth.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(
              left: map['sendByUser'] == _auth.currentUser!.uid
                  ? 100
                  : 8.0,
              right: map['sendByUser'] == _auth.currentUser!.uid
                  ? 8
                  : 100,
              top: 10,
              bottom: 10),
          child: CustomPaint(
            // size: const Size.fromWidth(50),
            painter: MessageBubble(
                color: map['sendByUser'] == _auth.currentUser!.uid
                    ? const Color(0xffDAF0F3)
                    : const Color(0xffC795B2),
                alignment: map['sendByUser'] == _auth.currentUser!.uid
                    ? Alignment.topRight
                    : Alignment.topLeft,
                tail: true),
            child: Padding(
              padding: EdgeInsets.only(
                  left: map['sendByUser'] == _auth.currentUser!.uid
                      ? 15
                      : 20,
                  right: map['sendByUser'] == _auth.currentUser!.uid
                      ? 20:15,
                  top: 10,
                  bottom: 10),
              child: Text(
                map['message'].toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15,
                    color: map['sendByUser'] != _auth.currentUser!.uid
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
      )
          :  Container(
        width: size.width,
        alignment: map['sendByUser'] == _auth.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          height: size.height / 2.5,
          width: size.width,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          alignment: map['sendByUser'] == _auth.currentUser!.uid
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: InkWell(
            onTap: () => Get.to(
              ShowImage(
                imageUrl: map['message'],
              ),
            ),
            child: Container(
              height: size.height / 2.5,
              width: size.width / 2,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(15)),
              alignment: map['message'] != "" ? null : Alignment.center,
              child: map['message'] != ""
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  map['message'],
                  fit: BoxFit.cover,
                ),
              )
                  : const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );

  }

  Future<void> showDeleteMessageDialog(BuildContext context, firestore.DocumentReference messageRef) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Message"),
            content: const Text("Are you sure you want to delete this message?"),
            actions: <Widget>[
              TextButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Delete"),
                onPressed: () async {
                  _firestore
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats').doc('id').delete();
                  // Use the provided messageRef to delete the document
                  await messageRef.delete().then((value) => Navigator.of(context).pop());
                },
              ),
            ],
          );
        }
    );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl, fit: BoxFit.fill),
      ),
    );
  }
}