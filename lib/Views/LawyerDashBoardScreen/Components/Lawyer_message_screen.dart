import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Utils/colors.dart';
import '../../../Widgets/custom_appbar.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import 'package:firebase_database/firebase_database.dart';

class LawyerMessageScreen extends StatefulWidget {
  final String clientName;

  const LawyerMessageScreen({Key? key, required this.clientName}) : super(key: key);

  @override
  State<LawyerMessageScreen> createState() => _LawyerMessageScreenState();
}

class _LawyerMessageScreenState extends State<LawyerMessageScreen> {
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  DatabaseReference _messagesRef = FirebaseDatabase.instance.reference().child('messages');

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
              stream: _messagesRef.orderByChild('receiver').equalTo(widget.clientName).onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                  return Center(child: Text('No messages yet'));
                }

                Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                List<Map<String, dynamic>> messages = [];
                data.forEach((key, value) {
                  messages.add(Map<String, dynamic>.from(value));
                });

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
    bool isSentByUser = true; // Example logic to differentiate between sent and received messages
    String message = messageData['message'] ?? '';

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
                    onPressed: () {},
                    icon: Icon(Icons.attach_file_rounded, color: AppColors.tealB3, size: 28.sp),
                  ),
                  IconButton(
                    onPressed: () {
                      _sendMessage();
                    },
                    icon: Icon(Icons.camera_alt_rounded, color: AppColors.tealB3, size: 28.sp),
                  )
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              _sendMessage();
            },
            shape: CircleBorder(),
            color: AppColors.tealB3,
            padding: EdgeInsets.all(12.r),
            minWidth: 0,
            child: Icon(Icons.send, color: AppColors.white, size: 30.sp),
          )
        ],
      ),
    );
  }

  void _sendMessage() async {
    String message = _textEditingController.text.trim();
    if (message.isNotEmpty) {
      try {
        await _messagesRef.push().set({
          'message': message,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'receiver': widget.clientName,
        });
        _textEditingController.clear();
        _scrollController.animateTo(
          0.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }
}
