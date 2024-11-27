import 'package:baca_berita/controller/home/news_controller.dart';
import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:baca_berita/widgets/shimmer/shimmer_loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CarouselNews extends StatelessWidget {
  final NewsController newsController = Get.find<NewsController>();

  CarouselNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Obx(() {
        if (newsController.loadingFetchNews.value == DataLoad.loading) {
          // Shimmer placeholder for loading
          return CarouselSlider(
            options: CarouselOptions(
              height: 250,
              aspectRatio: 0.95,
              autoPlay: false,
            ),
            items: List.generate(
              5, // Jumlah shimmer placeholder
              (index) => Container(
                margin: const EdgeInsets.only(right: 8),
                width: Get.width * 0.78,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ShimmerCarouselBooks(),
              ),
            ),
          );
        } else if (newsController.loadingFetchNews.value == DataLoad.failed) {
          return const Center(
            child: Text(
              "Failed to load data",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        } else if (newsController.listNews.isEmpty) {
          return const Center(
            child: Text(
              "No data available",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          final displayedNews = newsController.listNews.take(10).toList();

          return CarouselSlider(
            options: CarouselOptions(
              height: 250,
              aspectRatio: 0.95,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items: displayedNews.map((news) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    RouteName.detailPage,
                    arguments: {
                      'title': news.title,
                      'description': news.description,
                      'coverUrl': news.coverUrl,
                      'created_at': news.createdAt,
                    },
                  );
                },
                child: Container(
                  width: Get.width * 0.78,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      // Gambar latar belakang
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          news.coverUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      // Overlay gelap
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                              Colors.black.withOpacity(1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Teks di atas gambar
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            HtmlWidget(
                              news.description.length > 100
                                  ? "${news.description.substring(0, 100)}..."
                                  : news.description,
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              DateFormat.yMMMd().format(news.createdAt),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
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
                ),
              );
            }).toList(),
          );
        }
      }),
    );
  }
}


