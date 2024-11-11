// ignore_for_file: prefer_const_constructors

import 'package:baca_berita/controller/auth/sign_up_controller.dart';
import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/utilities/asset_constant.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:baca_berita/widgets/button/button_primary.dart';
import 'package:baca_berita/widgets/button/button_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final SignUpController controller = Get.put(SignUpController());
  final box = GetStorage(); // Initialize GetStorage

  @override
  Widget build(BuildContext context) {
    // Check if the user is already logged in
    if (box.read('token') != null) {
      Future.delayed(Duration.zero, () {
        Get.offAllNamed(RouteName.login); // Replace with your home page route
      });
      return Container(); // Return an empty container while redirecting
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColorSecondary,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: Get.height * 0.35,
              width: Get.width * 0.75,
              child: SvgPicture.asset(
                AssetConstant.icLogin,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0XFFF1F4FD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: const [
                          TextSpan(
                            text: "Daftar sekarang di ",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextSpan(
                            text: "BACA BERITA ",
                            style: TextStyle(
                              color: kColorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                              text:
                                  "untuk melihat berita terkini dan informasi menarik lainnya."),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),

                    // Text input for email
                    TextField(
                      autocorrect: false,
                      controller: controller.emailController.value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Text input for name
                    TextField(
                      autocorrect: false,
                      controller: controller.nameController
                          .value, // Use a separate controller for name
                      decoration: InputDecoration(
                        labelText: "Nama",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Text input for password
                    Obx(
                      () => TextField(
                        autocorrect: false,
                        controller: controller.passController.value,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isHidden.value,
                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isHidden.value =
                                  !controller.isHidden.value;
                            },
                            icon: Icon(controller.isHidden.isFalse
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Text input for password confirmation
                    Obx(
                      () => TextField(
                        autocorrect: false,
                        controller: controller.confirmPassController
                            .value, // Use a separate controller for confirmation
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isHidden.value,
                        decoration: InputDecoration(
                          labelText: "Konfirmasi Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isHidden.value =
                                  !controller.isHidden.value;
                            },
                            icon: Icon(controller.isHidden.isFalse
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // daftar Button
                    Buttonprimary(
                      onPressed: () {
                        controller.signUp(); // Call the signUp function
                      },
                      title: 'Daftar',
                      color: kColorPrimary,
                      width: 345,
                    ),

                    SizedBox(height: 15),
                    // Register Text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sudah punya akun? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Buttontext(
                          onTap: () {
                            Get.toNamed(RouteName.login);
                          },
                          title: "Masuk",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
