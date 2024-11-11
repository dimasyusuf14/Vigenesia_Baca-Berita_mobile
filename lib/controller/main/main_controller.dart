import 'package:baca_berita/model/main/item_navbar_model.dart';
import 'package:baca_berita/pages/home/add_news_page.dart';
import 'package:baca_berita/pages/home/home_page.dart';
import 'package:baca_berita/pages/profile/profile_page.dart';
import 'package:baca_berita/services/utilities/asset_constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// class MainController extends GetxController {
//   var selectedIndex = 0.obs;
//   var profilePicture = 'assets/images/default_profile_picture.png'.obs;

//   void updateProfilePicture(String newPicture) {
//     profilePicture.value = newPicture;
//   }

//   List<ItemNavbarModel> items = [
//     ItemNavbarModel(
//       widget: HomePage(),
//       icon: AssetConstant.icBeranda, // SVG icon
//       title: "Beranda",
//     ),
//     ItemNavbarModel(
//       widget: AddNewsPage(),
//       icon: AssetConstant.icPlus, // Regular Icon
//       title: "Tambah",
//     ),
//     ItemNavbarModel(
//       widget: ProfilePage(),
//       icon: AssetConstant.icProfile, // Regular Icon
//       title: "Profile",
//     ),
//   ];
// }

class MainController extends GetxController {
  var selectedIndex = 0.obs;
  var profilePicture = 'assets/images/default_profile_picture.png'.obs;
  final box = GetStorage(); // Access GetStorage to read the user role

  void updateProfilePicture(String newPicture) {
    profilePicture.value = newPicture;
  }

  List<ItemNavbarModel> get items {
    List<ItemNavbarModel> baseItems = [
      ItemNavbarModel(
        widget: HomePage(),
        icon: AssetConstant.icBeranda, // SVG icon
        title: "Beranda",
      ),
      ItemNavbarModel(
        widget: ProfilePage(),
        icon: AssetConstant.icProfile, // Regular Icon
        title: "Profile",
      ),
    ];

    // Check user role and conditionally add the AddNewsPage
    if (box.read("role") == "admin") {
      // Ensure this key matches the key in LoginController
      baseItems.insert(
        1,
        ItemNavbarModel(
          widget: AddNewsPage(),
          icon: AssetConstant.icPlus, // Regular Icon
          title: "Tambah",
        ),
      );
    }

    return baseItems;
  }
}
