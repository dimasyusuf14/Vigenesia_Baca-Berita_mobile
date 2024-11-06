// // ignore_for_file: prefer_const_constructors

// import 'dart:io';

// import 'package:baca_berita/controller/home/news_controller.dart';
// import 'package:baca_berita/services/utilities/utilities.dart';
// import 'package:baca_berita/widgets/button/button_primary.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddNewsPage extends StatelessWidget {
//   final NewsController newsController = Get.put(NewsController());

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   AddNewsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add News'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () async {
//               // Call the addNews method on submit
//               await newsController.addNews(
//                 titleController.text,
//                 descriptionController.text,
//               );

//               // Clear the input fields
//               titleController.clear();
//               descriptionController.clear();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Obx(() {
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     newsController.pickImage();
//                   },
//                   child: Container(
//                     height: Get.height * 0.35,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8.0),
//                       image: newsController.selectedImage.value.isNotEmpty
//                           ? DecorationImage(
//                               image: FileImage(
//                                   File(newsController.selectedImage.value)),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     child: newsController.selectedImage.value.isEmpty
//                         ? Center(child: Text('Tap to select cover image'))
//                         : null,
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: titleController,
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: descriptionController,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                     border: OutlineInputBorder(),
//                   ),
//                   maxLines: 5,
//                 ),
//                 SizedBox(height: 16.0),
//                 Buttonprimary(
//                   title: "Add News",
//                   color: kColorPrimary,
//                   width: 230,
//                   onPressed: () async {
//                     await newsController.addNews(
//                       titleController.text,
//                       descriptionController.text,
//                     );
//                     titleController.clear();
//                     descriptionController.clear();
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 if (newsController.loadingFetchNews.value == DataLoad.loading)
//                   CircularProgressIndicator(),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:baca_berita/controller/home/news_controller.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:baca_berita/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewsPage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await newsController.addNews(
                titleController.text,
                descriptionController.text,
              );
              titleController.clear();
              descriptionController.clear();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    newsController.pickImage();
                  },
                  child: Container(
                    height: Get.height * 0.35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: newsController.selectedImage.value.isNotEmpty
                            ? FileImage(
                                File(newsController.selectedImage.value),
                              )
                            : NetworkImage(newsController.listNews.isNotEmpty &&
                                        newsController
                                            .listNews[0].coverUrl.isNotEmpty
                                    ? newsController.listNews[0].coverUrl
                                    : 'https://via.placeholder.com')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: newsController.selectedImage.value.isEmpty
                        ? Center(child: Text('Tap to select cover image'))
                        : null,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 16.0),
                Buttonprimary(
                  title: "Add News",
                  color: kColorPrimary,
                  width: Get.width * 1,
                  onPressed: () async {
                    await newsController.addNews(
                      titleController.text,
                      descriptionController.text,
                    );
                    titleController.clear();
                    descriptionController.clear();
                  },
                ),
                SizedBox(height: 16.0),
                if (newsController.loadingFetchNews.value == DataLoad.loading)
                  CircularProgressIndicator(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
