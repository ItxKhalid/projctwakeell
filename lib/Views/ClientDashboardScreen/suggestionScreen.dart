import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(style: TextStyle(color: Colors.white),maxLines: null,
                  controller: controller,
              onSaved: (value){
                if(controller.text != null)
                  Api(query: controller.text);
              },
              decoration: InputDecoration(hintText: 'Write your Query here',
                suffixIcon: InkWell(onTap:loading==false? (){
                  if(controller.text != null)
                  Api(query: controller.text);
                  setState(() {

                  });
                }:(){},
                    child:Icon(Icons.send)),
            
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder()
              )),
              SizedBox(height: 20),
           loading==false? loading==false && responseApi !=null?
              Container(padding: EdgeInsets.all(10),
            
                decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all(color: Colors.grey)),
              child: Center(child: Text('$responseApi'))):SizedBox.shrink():CircularProgressIndicator()
            ],),
          ),
        ),
      ),
    );
  }

bool loading=false;
  String? responseApi;

  void Api({required String query})async{

    try {
      loading=true;
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST', Uri.parse('https://developer900.pythonanywhere.com'));
      request.body = json.encode({
        "input_prompt": "$query"
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var geer = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        controller.clear();
        loading=false;
        responseApi=jsonDecode(geer.body);


        setState(() {

        });
        print(await response.stream.bytesToString());
      }
      else {
        print(response.reasonPhrase);
      }
    }catch (e){
      print(e);
    }

  }
}
