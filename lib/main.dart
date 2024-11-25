import 'package:baca_berita/pages/splash/splash_screen.dart';
import 'package:baca_berita/routes/page_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return RefreshConfiguration(
      footerBuilder: () => const ClassicFooter(
        loadingIcon: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: Colors.red,
              strokeWidth: 2,
            )),
      ),
      headerBuilder: () => const WaterDropMaterialHeader(
        backgroundColor: Colors.red,
        distance: 40,
      ),
      child: GetMaterialApp(
        title: 'Vigenesia',
        getPages: PagesRoute.pages,
        theme: ThemeData(
            useMaterial3: true,
            fontFamily: "Inter",
            splashColor: Colors.transparent),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
