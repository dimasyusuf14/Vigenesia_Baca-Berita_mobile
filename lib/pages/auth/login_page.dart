// ignore_for_file: prefer_const_constructors

import 'package:baca_berita/controller/auth/login_controller.dart';
import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/utilities/asset_constant.dart';
import 'package:baca_berita/widgets/button/button_primary.dart';
import 'package:baca_berita/widgets/button/button_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../services/utilities/utilities.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColorSecondary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: Get.height * 0.38,
              width: Get.width * 0.75,
              child: SvgPicture.asset(
                AssetConstant.icLogin,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0XFFF1F4FD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: const [
                          TextSpan(
                            text:
                                "Silahkan masuk untuk mengakses berita terkini di ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: "BACA BERITA",
                            style: TextStyle(
                              color: kColorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //text input nim atau email
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

                    SizedBox(
                      height: 20,
                    ),

                    //text input pw
                    Obx(
                      () => TextField(
                        autocorrect: false,
                        controller: controller.passController.value,
                        keyboardType: TextInputType.emailAddress,
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
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.checkC.value,
                            onChanged: (value) => controller.checkC.toggle(),
                            activeColor: kColorPrimary,
                          ),
                        ),
                        Text(
                          "Remember Me?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    // Login Button

                    Buttonprimary(
                      title: 'Masuk',
                      color: kColorPrimary,
                      onPressed: () {
                        controller.login();
                      },
                      width: 345,
                    ),

                    SizedBox(height: 20),
                    // Register Text
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Belum punya akun? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        Buttontext(
                          onTap: () {
                            Get.toNamed(RouteName.signUp);
                          },
                          title: "Daftar",
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
