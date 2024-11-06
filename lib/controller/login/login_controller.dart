import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/api_services.dart';
import 'package:baca_berita/services/utilities/api_constant.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var passController = TextEditingController(text: "password").obs;
  var emailController = TextEditingController(text: "user@mail.com").obs;
  var checkC = false.obs;
  var isHidden = false.obs;

  void login() async {
    Helper.loadingScreen();

    var requestBodyMap = {
      "email": emailController.value.text,
      "password": passController.value.text,
    };

    try {
      var data = await APIServices.api(
          endPoint: APIEndpoint.login,
          type: APIMethod.post,
          requestBodyMap: requestBodyMap);

      if (data['success'] == true) {
        Get.back();
        var token = data['data']['access_token'];
        final box = GetStorage();
        await box.write("token", token);
        Get.offAllNamed(RouteName.mainPage);
      } else {
        Get.back();
        Helper.setSnackbar('eror');
      }
    } catch (e) {
      Get.back();
      Helper.setSnackbar(e.toString());
      logPrint("ERR : ${e.toString()}");
    }
  }

  void logout() async {
    final box = GetStorage();
    await box.remove("token"); // Remove the stored token
    Get.toNamed(RouteName.login); // Navigate to the login page
  }

  void signUp() {}
}
