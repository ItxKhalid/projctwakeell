import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        title: Text('Chat Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Card(
                margin: EdgeInsets.all(30),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: messages.map((message) {
                      return ListTile(
                        title: Text(
                          message['sender'] == 'bot' ? 'Bot' : 'You',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(message['message']!),
                      );
                    }).toList(),
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
                        hintText: 'Enter your query',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey)
                        )
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size.fromHeight(60)),
                  ),
                  onPressed: () {
                    _sendQuery(controller.text);
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendQuery(String query) async {
    try {
      messages.add({'sender': 'user', 'message': query});
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