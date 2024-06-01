import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Widgets/custom_appbar.dart';

import 'Components/client_message_screen.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  bool loading = false;
  String? responseApi;

  // List of categories for the grid view

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final List<String> categories = [
      localizations.family,
      localizations.maintenance_of_minors,
      localizations.custody_of_minors,
      localizations.hesitation_rights,
      localizations.khula,
      localizations.divorce,
      localizations.guardian_minor_or_property,
      localizations.property_rights,
      localizations.inheritance,
      localizations.sales_purchase,
      localizations.rent_matters,
      localizations.eviction_of_house,
      localizations.criminal,
      localizations.fraud,
      localizations.check_out,
      localizations.theft_threats,
      localizations.assault,
    ];
    return SafeArea(
      child: Scaffold(
        appBar:  CustomAppBar(
          name: AppLocalizations.of(context)!.case_category,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: loading
                          ? null
                          : () {
                              setState(() {
                                selectedIndex = index;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecommendedLawyerScreen(
                                    query:
                                        'hello my case is related to ${categories[index]}',
                                  ),
                                ),
                              );
                            },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Colors.grey
                              : Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 50),
                loading
                    ? AppConst.spinKitWave()
                    : responseApi != null
                        ? Card(
                            elevation: 1,
                            margin: const EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text('$responseApi')),
                            ),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecommendedLawyerScreen extends StatefulWidget {
  final String query;

  const RecommendedLawyerScreen({Key? key, required this.query})
      : super(key: key);

  @override
  _RecommendedLawyerScreenState createState() =>
      _RecommendedLawyerScreenState();
}

class _RecommendedLawyerScreenState extends State<RecommendedLawyerScreen> {
  bool loading = false;
  String? responseApi;

  @override
  void initState() {
    super.initState();
    _fetchRecommendedLawyer(widget.query);
  }

  void _fetchRecommendedLawyer(String query) async {
    try {
      setState(() {
        loading = true;
      });

      var headers = {
        'Content-Type': 'application/json',
      };
      var request =
          http.Request('POST', Uri.parse('http://aipython.hamzaworld.com'));
      request.body = json.encode({"prompt": query});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseData = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        var data = jsonDecode(responseData.body);
        setState(() {
          responseApi = data['answer'];
          loading = false;
        });
        _showDialog(responseApi!);
      } else {
        print(response.reasonPhrase);
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  void _showDialog(String response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppLocalizations.of(context)!.recommended_lawyer),
          content: Text(response),
          actions: [
            TextButton(
              child:  Text(AppLocalizations.of(context)!.oK),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<DocumentSnapshot>> _fetchLawyers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('lawyer').get();
    return querySnapshot.docs;
  }

  void _fetchCaseTimePrediction() async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        builder: (context) {
          return AppConst.spinKitWave(); // Replace with your loading widget
        },
        barrierDismissible: false,
      );

      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request(
          'POST', Uri.parse('https://developer900.pythonanywhere.com'));
      request.body =
          json.encode({"input_prompt": "hi i have a case ${widget.query}"});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseData = await http.Response.fromStream(response);

      Navigator.pop(context); // Dismiss the loading dialog

      if (response.statusCode == 200) {
        var data = responseData.body;
        _showCaseTimeDialog(data); // Show the result dialog
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      Navigator.pop(
          context); // Ensure the loading dialog is dismissed in case of an error
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  void _showCaseTimeDialog(String response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(AppLocalizations.of(context)!.case_time_prediction),
          content: Text(response),
          actions: [
            TextButton(
              child:  Text(AppLocalizations.of(context)!.oK),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  String chatRoomId(String user1, String user2) {
    if (user1.isEmpty || user2.isEmpty) {
      return 'defaultRoomId';
    }

    user1 = user1.toLowerCase();
    user2 = user2.toLowerCase();

    if (user1[0].codeUnits[0] > user2[0].codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.recommended_lawyer),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (responseApi != null)
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      Card(
                        elevation: 1,
                        margin: const EdgeInsets.all(26),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(responseApi!)),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 25,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)))),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.teal)),
                            onPressed: _fetchCaseTimePrediction,
                            // Handle case time prediction here
                            child:  Text(AppLocalizations.of(context)!.case_time,
                                style: const TextStyle(color: Colors.white))),
                      )
                    ],
                  ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('lawyer').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No lawyer found'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var lawyerData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                            return _buildChatItem(lawyerData);
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
  Widget _buildChatItem(Map<String, dynamic> lawyerData) {
    String firstName = lawyerData['firstName'] ?? '';
    String lastName = lawyerData['lastName'] ?? '';
    String licenseNumber = lawyerData['email'] ?? '';
    String name = '$firstName $lastName'.trim();
    Timestamp timestamp = lawyerData['timestamp'] ?? Timestamp.now();
    String formattedTimestamp = DateFormat('MM/dd/yyyy, hh:mm a').format(timestamp.toDate());
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String roomId = chatRoomId(uid, lawyerData['userId']);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClientMessageScreen(
              clientName: name,
              clientId: lawyerData['userId'],
              chatRoomId: roomId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0, left: 16.0, right: 16.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/image11.png'),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$licenseNumber',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
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
}
