import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppImages {
  static String logoimg = "assets/images/logo.png";
  static String image1 = "assets/images/image1.png";
  static String profileimg = "assets/images/profileimg.png";
  static String image2 = "assets/images/image2.png";
  static String downicon = "assets/images/downicon.png";
  static String image3 = "assets/images/image3.png";
  static String image4 = "assets/images/image4.png";
  static String image5 = "assets/images/image5.png";
  static String image6 = "assets/images/image6.png";
  static String image7 = "assets/images/image7.png";
  static String image8 = "assets/images/image8.png";
  static String image9 = "assets/images/image9.png";
  static String image10 = "assets/images/image10.png";
  static String image11 = "assets/images/image11.png";
  static String image12 = "assets/images/image12.png";
  static String image13 = "assets/images/image13.png";
}

class AppConst {
  // void toastMassage(String massage,bool onError){
  //   Fluttertoast.showToast(
  //       msg: massage,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.TOP,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: onError==false ? Colors.green.withOpacity(0.9) :  Colors.redAccent,
  //       textColor: onError==false ? Colors.white : Colors.white,
  //       fontSize: MySize.size16
  //   );
  // }

  static String saveUserName = 'saveUserName';
  static String saveUserType = 'saveUserType';
  static String getUserName = '';
  static String getUserType = '';

  static spinKitWave() => const Center(
        child: SpinKitWave(
          size: 70,
          color: Colors.teal,
        ),
      );
}
