import 'package:get/get.dart';

class RadioListClientLawyerController extends GetxController {
  var radioclientvalue = RxnString();

  void changeRadioButtonClientLawyer(String? value) {
    radioclientvalue.value = value;
  }

}
