import 'package:baca_berita/model/home/home_model.dart';
import 'package:baca_berita/services/api_services.dart';
import 'package:baca_berita/services/utilities/api_constant.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewsController extends GetxController {
  var loadingFetchNews = DataLoad.done.obs;
  var listNews = <NewsModel>[].obs;
  var selectedDate = DateTime.now().obs;
  var selectedImage = ''.obs; // To store selected image path

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    getProductList();
    super.onInit();
  }

  // Method to pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = pickedFile.path;
    }
  }

  // Fetch news list
  void getProductList() async {
    loadingFetchNews.value = DataLoad.loading;

    try {
      var data = await APIServices.api(
        endPoint: APIEndpoint.news,
        type: APIMethod.get,
        withToken: true,
      );

      // Access the nested 'posts' list in the response data
      if (data['success'] == true) {
        var dataList = data['data']['posts'] as List;

        // Map the JSON to NewsModel instances
        List<NewsModel> list =
            dataList.map((e) => NewsModel.fromJson(e)).toList();

        // Sort the list based on created_at in descending order
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        // Assign the sorted list to the observable
        listNews.value = list;

        loadingFetchNews.value = DataLoad.done;
      } else {
        loadingFetchNews.value = DataLoad.failed;
      }
    } catch (e) {
      loadingFetchNews.value = DataLoad.failed;
      Get.snackbar("Error", "Failed to fetch news. Please try again.");
    }
  }

  // Add news with automatic createdAt date and cover image
  Future<void> addNews(String title, String description) async {
    loadingFetchNews.value = DataLoad.loading;

    // Create the news model with current date as createdAt
    NewsModel newNews = NewsModel(
      id: 0, // This would be handled by backend typically
      cover: selectedImage.value,
      title: title,
      description: description,
      createdAt: DateTime.now(), // Set createdAt to now
      updatedAt: DateTime.now(),
      coverUrl: '', // URL is typically set by backend after upload
    );

    try {
      var response = await APIServices.api(
        endPoint: APIEndpoint.news,
        type: APIMethod.post,
        withToken: true,
        requestBodyMap: newNews.toJson(),
      );

      if (response['success'] == true) {
        newNews.coverUrl =
            response['data']['cover_url'] ?? ''; // Get URL from the response
        getProductList();
        Get.snackbar("Success", "News added successfully!");
      } else {
        Get.snackbar("Error", "Failed to add news.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add news. Please try again.");
    } finally {
      loadingFetchNews.value = DataLoad.done;
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }
}
