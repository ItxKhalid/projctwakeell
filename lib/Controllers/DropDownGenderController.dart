import 'package:get/get.dart';

class GenderDropDownController extends GetxController {
  RxString dropdownValue = "Female".obs;

  void changeGenderDropDown(String value) {
    dropdownValue.value = value;
  }

  String getSelectedGender() {
    return dropdownValue.value;
  }
}
