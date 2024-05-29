// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart ' as http;
// // class SuggestionScreen extends StatefulWidget {
// //   const SuggestionScreen({super.key});
// //
// //   @override
// //   State<SuggestionScreen> createState() => _SuggestionScreenState();
// // }
// //
// // class _SuggestionScreenState extends State<SuggestionScreen> {
// //   TextEditingController controller =TextEditingController();
// //   @override
// //   Widget build(BuildContext context) {
// //     return  SafeArea(
// //       child: Scaffold(
// //         body: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
// //           child: SingleChildScrollView(
// //             child: Column(children: [
// //               TextFormField(style: const TextStyle(color: Colors.white),maxLines: null,
// //                   controller: controller,
// //               onSaved: (value){
// //                 if(controller.text != null)
// //                   Api(query: controller.text);
// //               },
// //               decoration: InputDecoration(hintText: 'Write your Query here',
// //                 suffixIcon: InkWell(onTap:loading==false? (){
// //                   if(controller.text != null) {
// //                     Api(query: controller.text);
// //                   }
// //                   setState(() {
// //
// //                   });
// //                 }:(){},
// //                     child:const Icon(Icons.send)),
// //
// //                 hintStyle: const TextStyle(color: Colors.grey),
// //                 border: const OutlineInputBorder()
// //               )),
// //               const SizedBox(height: 20),
// //            loading==false? loading==false && responseApi !=null?
// //               Container(padding: const EdgeInsets.all(10),
// //
// //                 decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all(color: Colors.grey)),
// //               child: Center(child: Text('$responseApi'))):const SizedBox.shrink():const CircularProgressIndicator()
// //             ],),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// // bool loading=false;
// //   String? responseApi;
// //
// //   void Api({required String query})async{
// //
// //     try {
// //       loading=true;
// //       var headers = {
// //         'Content-Type': 'application/json'
// //       };
// //       var request = http.Request(
// //           'POST', Uri.parse('https://developer900.pythonanywhere.com'));
// //       request.body = json.encode({
// //         "input_prompt": "$query"
// //       });
// //       request.headers.addAll(headers);
// //
// //       http.StreamedResponse response = await request.send();
// //       var geer = await http.Response.fromStream(response);
// //       if (response.statusCode == 200) {
// //         controller.clear();
// //         loading=false;
// //         responseApi=jsonDecode(geer.body);
// //
// //
// //         setState(() {
// //
// //         });
// //         print(await response.stream.bytesToString());
// //       }
// //       else {
// //         print(response.reasonPhrase);
// //       }
// //     }catch (e){
// //       print(e);
// //     }
// //
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:projctwakeell/Utils/images.dart';
// import 'package:projctwakeell/Widgets/custom_appbar.dart';
//
// class SuggestionScreen extends StatefulWidget {
//   const SuggestionScreen({super.key});
//
//   @override
//   State<SuggestionScreen> createState() => _SuggestionScreenState();
// }
//
// class _SuggestionScreenState extends State<SuggestionScreen> {
//   bool loading = false;
//   String? responseApi;
//
//   // List of categories for the grid view
//   final List<String> categories = [
//     'Family',
//     'Maintenance of minors',
//     'Custody of minors',
//     'Hesitation rights',
//     'Khula',
//     'Divorce',
//     'Guardian minor or property',
//     'Property rights',
//     'Inheritance',
//     'Sales & purchase',
//     'Rent matters',
//     'Ebicion of house',
//     'Criminal',
//     'Fraud',
//     'Check out',
//     'Theft /threats',
//     'Assault',
//   ];
//
//   void Api({required String query}) async {
//     try {
//       setState(() {
//         loading = true;
//       });
//
//       var headers = {
//         'Content-Type': 'application/json',
//       };
//       var request = http.Request(
//           'POST', Uri.parse('https://developer900.pythonanywhere.com'));
//       request.body = json.encode({"input_prompt": query});
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//       var responseData = await http.Response.fromStream(response);
//       if (response.statusCode == 200) {
//         setState(() {
//           responseApi = jsonDecode(responseData.body);
//           loading = false;
//         });
//       } else {
//         print(response.reasonPhrase);
//         setState(() {
//           loading = false;
//         });
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         loading = false;
//       });
//     }
//   }
//
//   int? selectedIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: const CustomAppBar(
//           name: 'Cases Categories',
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 GridView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                     childAspectRatio: 4,
//                   ),
//                   itemCount: categories.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: loading
//                           ? null
//                           : () {
//                               setState(() {
//                                 selectedIndex = index;
//                               });
//                               Api(query: 'case about ${categories[index]}');
//                             },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: selectedIndex == index
//                               ? Colors.grey
//                               : Colors.teal,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             categories[index],
//                             style: const TextStyle(color: Colors.white),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 50),
//                 loading
//                     ? AppConst.spinKitWave()
//                     : responseApi != null
//                         ? Card(
//                             elevation: 1,
//                             margin: const EdgeInsets.all(10),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(child: Text('$responseApi')),
//                             ),
//                           )
//                         : const SizedBox.shrink(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projctwakeell/Utils/images.dart';
import 'package:projctwakeell/Widgets/custom_appbar.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  bool loading = false;
  String? responseApi;

  // List of categories for the grid view
  final List<String> categories = [
    'Family',
    'Maintenance of minors',
    'Custody of minors',
    'Hesitation rights',
    'Khula',
    'Divorce',
    'Guardian minor or property',
    'Property rights',
    'Inheritance',
    'Sales & purchase',
    'Rent matters',
    'Ebicion of house',
    'Criminal',
    'Fraud',
    'Check out',
    'Theft /threats',
    'Assault',
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          name: 'Cases Categories',
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
          title: const Text("Recommended Lawyer"),
          content: Text(response),
          actions: [
            TextButton(
              child: const Text("OK"),
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
      var request = http.Request('POST', Uri.parse('https://developer900.pythonanywhere.com'));
      request.body = json.encode({
        "input_prompt": "hi i have a case ${widget.query}"
      });
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
      Navigator.pop(context); // Ensure the loading dialog is dismissed in case of an error
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
          title: const Text("Case Time Prediction"),
          content: Text(response),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommended Lawyer"),
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
                          shape: MaterialStatePropertyAll(OvalBorder()),
                          backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                      onPressed: _fetchCaseTimePrediction, // Handle case time prediction here
                      child: const Text('Case Time', style: TextStyle(color: Colors.white))),
                )
              ],
            ),
          Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
              future: _fetchLawyers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error fetching lawyers"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No lawyers found"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var lawyer =
                      snapshot.data![index].data() as Map<String, dynamic>;
                      return ListTile(
                        leading: PhysicalModel(
                          color: Colors.white,
                          clipBehavior: Clip.hardEdge,
                          shape: BoxShape.circle,
                          child: CircleAvatar(
                            radius: 30,
                            child: lawyer['image'] == null
                                ? Image.asset(AppImages.profileimg, fit: BoxFit.cover)
                                : Image.network(lawyer['image']),
                          ),
                        ),
                        title: Text(lawyer['firstName'] + " " + lawyer['lastName']),
                        subtitle: Text(lawyer['licenseNumber']),
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