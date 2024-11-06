

import 'package:baca_berita/pages/home/detail_page.dart';
import 'package:baca_berita/pages/home/home_page.dart';
import 'package:baca_berita/pages/login/login_page.dart';
import 'package:baca_berita/pages/main/main_page.dart';
import 'package:baca_berita/routes/route_name.dart';
import 'package:get/get.dart';
// import 'package:alinea/pages/home/detail_home_page.dart';

class PagesRoute {
  static final pages = [
    GetPage(name: RouteName.login, page: () => LoginPage()),
    GetPage(name: RouteName.homePage, page: () => HomePage()),
    GetPage(name: RouteName.mainPage, page: () => MainPage()),
    GetPage(name: RouteName.detailPage, page: () => DetailPage()),
  ];
}
