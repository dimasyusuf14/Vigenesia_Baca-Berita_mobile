// ignore_for_file: prefer_const_constructors

import 'package:baca_berita/controller/auth/login_controller.dart';
import 'package:baca_berita/services/utilities/asset_constant.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:baca_berita/widgets/button/button_list_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: Get.width * 0.7,
          width: Get.width,
          decoration: BoxDecoration(
            color: kColorSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 60,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(AssetConstant.profilePict),
                ),
                SizedBox(height: 20),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "user@example.com",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonListProfile(
                  onPressed: () {
                    LoginController().logout();
                  },
                  assetName: AssetConstant.icLogout,
                  title: 'Keluar',
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
