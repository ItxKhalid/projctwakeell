import 'dart:developer';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'Userclass.dart';

class FirebaseHelper {
  static Future<UserModel?> getUserModelById(String? id) async {
    print("id: $id");
    UserModel? userModel;
    DocumentSnapshot snap =
    await FirebaseFirestore.instance.collection("users").doc(id).get().then(
          (value) {
        //print("data obtained: ${value.data()}");
        return value;
      },
    );


    return userModel;
  }
}
