import 'package:baca_berita/model/main/item_navbar_model.dart';
import 'package:baca_berita/pages/home/add_news_page.dart';
import 'package:baca_berita/pages/home/home_page.dart';
import 'package:baca_berita/pages/profile/profile_page.dart';
import 'package:baca_berita/services/utilities/asset_constant.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  var profilePicture = 'assets/images/default_profile_picture.png'.obs;

  void updateProfilePicture(String newPicture) {
    profilePicture.value = newPicture;
  }

  List<ItemNavbarModel> items = [
    ItemNavbarModel(
      widget: HomePage(),
      icon: AssetConstant.icBeranda, // SVG icon
      title: "Beranda",
    ),
    ItemNavbarModel(
      widget: AddNewsPage(),
      icon: AssetConstant.icPlus, // Regular Icon
      title: "Tambah",
    ),
    ItemNavbarModel(
      widget: ProfilePage(),
      icon: AssetConstant.icProfile, // Regular Icon
      title: "Profile",
    ),
  ];
}
