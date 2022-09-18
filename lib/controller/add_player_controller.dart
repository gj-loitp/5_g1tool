import 'package:get/get.dart';

class AddPlayerController extends GetxController {
  var name = "".obs;

  void setName(String s) {
    name.value = s;
  }

  bool isValidName() {
    return name.value.isNotEmpty;
  }
}
