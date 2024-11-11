// ignore_for_file: avoid_print

import 'dart:io';

import 'package:baca_berita/model/home/home_model.dart';
import 'package:baca_berita/pages/main/main_page.dart';
import 'package:baca_berita/services/api_services.dart';
import 'package:baca_berita/services/utilities/api_constant.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class NewsController extends GetxController {
  var loadingFetchNews = DataLoad.done.obs;
  var listNews = <NewsModel>[].obs;
  var selectedDate = DateTime.now().obs;
  // var selectedImage = ''.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  var isLoading = false.obs;
  // final ImagePicker _picker = ImagePicker();
  final APIServices _apiService = APIServices();

  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  @override
  void onInit() {
    getProductList();
    super.onInit();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
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

  void resetForm() {
    titleController.value.clear(); // Reset judul
    descriptionController.value.clear(); // Reset artikel
    selectedImage.value = null; // Reset gambar
  }

  bool _validateForm() {
    if (selectedImage.value == null || // Validasi agar gambar tidak null
        titleController.value.text.isEmpty ||
        descriptionController.value.text.isEmpty) {
      Get.snackbar('Error', 'Semua field harus diisi');
      return false;
    }
    return true;
  }

  void clearForm() {
    selectedImage.value = null;
    titleController.value.clear(); // Reset judul
    descriptionController.value.clear();
  }

  Future<void> insertBerita() async {
    Helper.loadingScreen();
    if (_validateForm()) {
      isLoading.value = true;

      // Pastikan `selectedImage` sudah memiliki file gambar yang dipilih
      if (selectedImage.value == null) {
        Get.snackbar('Error', 'Silakan pilih gambar');
        isLoading.value = false;
        return;
      }

      // Buat objek berita dengan menggunakan selectedKategoriId dan path gambar
      final berita = NewsModel(
        id: 0,
        title: titleController.value.text,
        description: descriptionController.value.text,
        cover: basename(
            selectedImage.value!.path), // Pastikan ini adalah nama file gambar
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Cetak data yang akan dikirim
      print('Data yang dikirim:');
      print('Judul: ${berita.title}');
      print('Artikel: ${berita.description}');
      print('Path Gambar: ${berita.cover}');

      try {
        await _apiService.insertBerita(berita, selectedImage.value);
        Get.offAll(() => MainPage());
        clearForm();

        Get.snackbar('Success', 'Berita berhasil disimpan');
        // clearForm();
      } catch (e) {
        Get.snackbar('Error', 'Gagal menyimpan berita: $e');
      } finally {
        isLoading.value = false;
      }
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
