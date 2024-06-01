import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterYourQuery,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey)
                        )
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size.fromHeight(60)),
                  ),
                  onPressed: () {
                    _sendQuery(controller.text);
                  },
                  child:  Text(AppLocalizations.of(context)!.send),
                ),
              ],
            ),
          ),
        ],
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
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
    try {
      setState(() {
        messages.add({'sender': 'user', 'message': query});
      });

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
        controller.clear();
      } else {
        setState(() {
          errorMessage = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Exception: $e';
      });
    }
  }
}
