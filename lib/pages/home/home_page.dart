// ignore_for_file: prefer_const_constructors

import 'package:baca_berita/controller/home/news_controller.dart';
import 'package:baca_berita/pages/home/widgets/book_carousel.dart';
import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  NewsController controller = Get.put(NewsController());
  final box = GetStorage(); // Initialize GetStorage

  // Fungsi untuk refresh data
  Future<void> _refreshData() async {
    controller.getProductList(); // Fungsi fetch data dari controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25),
            color: Color(0XFFFF8A80),
            height: Get.height * 0.1,
            width: Get.width,
            child: Center(
              child: Text(
                "Portal Berita",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: Get.height * 0.35,
            width: Get.width,
            child: CarouselBook(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Text(
                  "Berita Terbaru",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () {
                        if (controller.loadingFetchNews.value ==
                            DataLoad.loading) {
                          return CircularProgressIndicator();
                        } else if (controller.loadingFetchNews.value ==
                            DataLoad.failed) {
                          return Text(
                            "FAILED",
                            style: TextStyle(
                              fontSize: 32.0,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: MasonryGridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.listNews.length,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 8,
                              padding: EdgeInsets.zero,
                              crossAxisCount: 1,
                              itemBuilder: (context, index) {
                                final news = controller.listNews[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFE4E1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    child: InkWell(
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                            child: Image.network(
                                              news.coverUrl,
                                              width: Get.width * 0.4,
                                              height: Get.height * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: Get.height * 0.2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    news.title,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  HtmlWidget(
                                                    news.description.length >
                                                            100
                                                        ? "${news.description.substring(0, 85)}..."
                                                        : news.description,
                                                    textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Text(
                                                    DateFormat.yMMMd().format(
                                                        news.createdAt),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
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
