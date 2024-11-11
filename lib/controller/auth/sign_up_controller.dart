// import 'package:baca_berita/services/api_services.dart';
// import 'package:baca_berita/services/utilities/api_constant.dart';
// import 'package:baca_berita/services/utilities/utilities.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class SignUpController extends GetxController {
//   var passController = TextEditingController().obs;
//   var emailController = TextEditingController().obs;

//   var isHidden = false.obs;

//   void signUp() async {
//     Helper.loadingScreen();

//     var requestBodyMap = {
//       "email": emailController.value.text,
//       "password": passController.value.text,
//     };

//     try {
//       var data = await APIServices.api(
//           endPoint: APIEndpoint.register,
//           type: APIMethod.post,
//           requestBodyMap: requestBodyMap,
//           withToken: false);

//       if (data['status'] == true) {
//         Get.back();
//         var token = data['data']['access_token'];
//         final box = GetStorage();
//         await box.write("token", token);
//       } else {
//         Get.back();
//         Helper.setSnackbar('eror');
//       }
//     } catch (e) {
//       Get.back();
//       Helper.setSnackbar(e.toString());
//       logPrint("ERR : ${e.toString()}");
//     }
//   }

//   void login() {}
// }

import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/api_services.dart';
import 'package:baca_berita/services/utilities/api_constant.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpController extends GetxController {
  var emailController = TextEditingController().obs;
  var nameController = TextEditingController().obs; // Add this line
  var passController = TextEditingController().obs;
  var confirmPassController = TextEditingController().obs;

  var isHidden = false.obs;

  void signUp() async {
    Helper.loadingScreen();

    var requestBodyMap = {
      "name": nameController.value.text,
      "email": emailController.value.text,
      "password": passController.value.text,
    };

    try {
      var data = await APIServices.api(
          endPoint: APIEndpoint.register,
          type: APIMethod.post,
          requestBodyMap: requestBodyMap,
          withToken: false);

      if (data['success'] == true) {
        // Check for success
        Get.back();
        var token = data['data']['access_token'];
        Get.offAllNamed(RouteName.signUp); // Access the token correctly
        final box = GetStorage();
        await box.write("token", token);

        var user = data['data']['user'];
        await box.write("user_role", user['role']);

        // Optionally, you can also save user information if needed
        await box.write("user_id", user['id']);
        await box.write("user_email", user['email']);
        await box.write("user_name", user['name']);

        // Optionally navigate to another screen or show a success message
      } else {
        Get.back();
        Helper.setSnackbar(
            'Error: ${data['message']}'); // Show the error message
      }
    } catch (e) {
      Get.back();
      Helper.setSnackbar('An error occurred: ${e.toString()}');
      logPrint("ERR : ${e.toString()}");
    }
  }

  void login() {
    // Implement login functionality if needed
  }
}
