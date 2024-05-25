import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:projctwakeell/Widgets/custome_appbar_client.dart';
import 'package:projctwakeell/service/Userclass.dart';
import 'package:projctwakeell/service/chat_room_model.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientMessageScreen extends StatefulWidget {
  final User? firebaseUser;
  final UserModel targetUser;
  final UserModel userModel;
  final ChatRoomModel chatRoom;

  const ClientMessageScreen({
    Key? key,
    required this.firebaseUser,
    required this.targetUser,
    required this.userModel,
    required this.chatRoom,
  }) : super(key: key);

  @override
  State<ClientMessageScreen> createState() => _ClientMessageScreenState();
}

class _ClientMessageScreenState extends State<ClientMessageScreen> {
  DatabaseReference? _messagesRef;
  TextEditingController _messageController = TextEditingController();
  String lastMessage = '';

  @override
  void initState() {
    super.initState();
   // _messagesRef = FirebaseDatabase.instance.reference().child('messages').child(widget.chatRoom.chatRoomId);

    _fetchLastMessage();
  }

  void _fetchLastMessage() {
    _messagesRef!.orderByChild('timestamp').limitToLast(1).onChildAdded.listen((event) {
      setState(() {
        Map<String, dynamic> messageData = Map<String, dynamic>.from(event.snapshot.value as Map);
        lastMessage = messageData['content'] ?? 'No message';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);

    return Scaffold(
      appBar: CustomAppBarClient(
        name: widget.targetUser.firstName ?? '',
        imageassets: 'assets/images/image11.png',
        onPhonePressed: () {
          // Handle phone icon pressed
        },
        subtitle: '',
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _messagesRef!.orderByChild('timestamp').onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                  return Center(
                    child: Text(
                      'No messages yet',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  );
                }

                Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                List<Map<String, dynamic>> messagesList = [];
                data.forEach((key, value) {
                  messagesList.add(Map<String, dynamic>.from(value));
                });
                messagesList.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

                return ListView.builder(
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    var messageData = messagesList[index];
                    bool isSentByUser = messageData['senderId'] == widget.firebaseUser!.uid;

                    return _buildChatItem(messageData, isSentByUser);
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

  Widget _buildChatItem(Map<dynamic, dynamic> messageData, bool isSentByUser) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByUser)
            CircleAvatar(
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
              messageData['content'],
              style: TextStyle(
                color: isSentByUser ? Colors.white : AppColors.black,
                fontSize: 16.sp,
              ),
            ),
          ),
          if (isSentByUser)
            SizedBox(width: 8.w),
          if (isSentByUser)
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image11.png'),
            ),
        ],
      ),
    );
  }

 Widget _buildInputArea(ThemeChangerProvider themeProvider) {
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
                    icon: Icon(Icons.emoji_emotions, color: AppColors.tealB3, size: 28.sp,),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
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
                      onFieldSubmitted: (value) {
                        _sendMessage();
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.attach_file_rounded, color: AppColors.tealB3, size: 28.sp),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.camera_alt_rounded, color: AppColors.tealB3, size: 28.sp),
                  )
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: _sendMessage,
            shape: CircleBorder(),
            color: AppColors.tealB3,
            padding: EdgeInsets.all(12.r),
            minWidth: 0,
            child: Icon(Icons.send, color: AppColors.white, size: 30.sp,),
          )
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    _messagesRef!.push().set({
      'content': _messageController.text.trim(),
      'senderId': widget.firebaseUser!.uid,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    _messageController.clear();
  }
}

