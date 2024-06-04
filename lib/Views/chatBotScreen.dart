import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../themeChanger/themeChangerProvider/theme_changer_provider.dart';
import '../Utils/colors.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  TextEditingController controller = TextEditingController();
  String responseApi = '';
  String errorMessage = '';
  List<Map<String, String>> messages = [];
  bool isLoading = false; // Add this variable to track loading state

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeChangerProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.chatBot),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Card(
                  margin: const EdgeInsets.all(30),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: _buildMessagesWithDividers(),
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading) // Display loading indicator if isLoading is true
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.teal),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextFormField(
                                controller: controller,
                                cursorColor: AppColors.tealB3,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                textInputAction: TextInputAction.send,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context)!.enterYourQuery,
                                  hintStyle: TextStyle(
                                    color: themeProvider.themeMode == ThemeMode.dark ? AppColors.white : AppColors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){
                      _sendQuery(controller.text);
                    },
                    shape: const CircleBorder(),
                    color: AppColors.tealB3,
                    padding: EdgeInsets.all(12.r),
                    minWidth: 0,
                    child: Icon(Icons.send, color: AppColors.white, size: 30.sp),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMessagesWithDividers() {
    List<Widget> messageWidgets = [];
    for (int i = 0; i < messages.length; i++) {
      messageWidgets.add(
        ListTile(
          title: Text(
            messages[i]['sender'] == 'bot' ? 'Bot' : 'You',
            style:  TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.tealB3
            ),
          ),
          subtitle: Text(messages[i]['message']!),
        ),
      );
      if (i % 2 == 1 && i < messages.length - 1) {
        // Add a divider after each pair of messages (user + bot)
        messageWidgets.add(const Divider());
      }
    }
    return messageWidgets;
  }

  Future<void> _sendQuery(String query) async {
    setState(() {
      messages.add({'sender': 'user', 'message': query});
      isLoading = true; // Set loading state to true
    });

    try {
      var headers = {'Content-Type': 'application/json'};
      var requestBody = json.encode({"prompt": query});
      var response = await http.post(
        Uri.parse('https://khanattaurrehman.pythonanywhere.com'),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        setState(() {
          messages.add({'sender': 'bot', 'message': response.body});
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Exception: $e';
      });
    } finally {
      setState(() {
        isLoading = false; // Set loading state to false
      });
    }
    controller.clear(); // Clear the input field
  }
}
