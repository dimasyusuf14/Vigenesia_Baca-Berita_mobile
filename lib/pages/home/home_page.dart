import 'package:baca_berita/controller/home/news_controller.dart';
import 'package:baca_berita/pages/home/widgets/news_carousel.dart';
import 'package:baca_berita/routes/route_name.dart';
import 'package:baca_berita/services/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

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
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 25),
              color: const Color(0XFFFF8A80),
              height: Get.height * 0.1,
              width: Get.width,
              child: const Center(
                child: Text(
                  "VIGENESIA",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: Get.height * 0.35,
              width: Get.width,
              child: CarouselNews(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () {
                        if (controller.loadingFetchNews.value ==
                            DataLoad.loading) {
                          // Tampilkan shimmer di dalam container
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 5, // Jumlah shimmer
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE4E1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: Get.width * 0.4,
                                        height: Get.height * 0.2,
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              height: 20,
                                              width: double.infinity,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              height: 35,
                                              width: Get.width * 0.5,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              height: 15,
                                              width: Get.width * 0.4,
                                              color: Colors.amber.shade300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (controller.loadingFetchNews.value ==
                            DataLoad.failed) {
                          return const Text(
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
                                  decoration: const BoxDecoration(
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              height: Get.height * 0.2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    news.title,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxHeight: 60),
                                                    child: HtmlWidget(
                                                      news.description.length >
                                                              100
                                                          ? "${news.description.substring(0, 85)}..."
                                                          : news.description,
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    DateFormat.yMMMd()
                                                        .format(news.createdAt),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: kColorPrimary,
                                                      fontWeight:
                                                          FontWeight.w600,
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
          ],
        ),
      ),
    );
  }
}
