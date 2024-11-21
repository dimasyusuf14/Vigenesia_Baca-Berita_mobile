import 'dart:async';


import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/utilities/asset_constant.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    final box = GetStorage();
    var duration = const Duration(seconds: 1);
    Timer(duration, () async {
      if (box.read('token') != null) {
        logPrint("TOKEN : ${box.read('token')}");
        Get.offAllNamed(RouteName.mainPage);
      } else {
        Get.offAllNamed(RouteName.login);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorSecondary,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(AssetConstant.logo,
              width: Get.width*0.5,),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Baca Berita",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 3,
              width: 160,
              decoration: BoxDecoration(
                color: kColorPrimary,
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
