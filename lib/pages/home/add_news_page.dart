// ignore_for_file: prefer_const_constructors

import 'package:baca_berita/controller/home/news_controller.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:baca_berita/widgets/button/button_primary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewsPage extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  AddNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
        backgroundColor: kColorSecondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: Obx(() {
                    return controller.selectedImage.value == null
                        ? Container(
                            height: Get.height * 0.35,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                                child: Text('Tap to select cover image')),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              controller.selectedImage.value!,
                              height: Get.height * 0.35,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          );
                  }),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: controller.titleController.value,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: controller.descriptionController.value,
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
                      controller.insertBerita();
                    }),
                SizedBox(height: 16.0),
              ],
            ),
          );
        }),
      ),
    );
  }
}
