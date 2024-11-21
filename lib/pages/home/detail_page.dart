// ignore_for_file: prefer_const_constructors

import 'package:baca_berita/controller/home/news_controller.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> news = Get.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0XFFE0E8F9),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: Get.height * 0.4,
                width: Get.width,
                decoration: BoxDecoration(
                  color: const Color(0XFF445DCC),
                  // borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  news['coverUrl'] ?? '', // Handle null cases
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    // color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.black
                            .withOpacity(0.6), // Membuat hitam lebih pekat
                        Colors.black.withOpacity(0.5), // Transisi ke transparan
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news['title'] ?? 'Title Not Available',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat.yMMMd().format(news["created_at"]),
                      style: TextStyle(
                        fontSize: 16,
                        color: kColorPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0XFFF1F4FD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.55,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: 10),
                            HtmlWidget(
                              news['description'] ??
                                  'Description not available.',
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
