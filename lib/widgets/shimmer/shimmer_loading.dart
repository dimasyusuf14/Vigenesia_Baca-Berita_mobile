import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBooksHomePage extends StatelessWidget {
  const ShimmerBooksHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Container(
                width: Get.width * 0.4,
                height: Get.height * 0.2,
                color: Colors.grey.shade300,
              ),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor:
                      Colors.grey.shade100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 45,
                      width: Get.width * 0.5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor:
                      Colors.grey.shade100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 15,
                      width: Get.width * 0.4,
                      color: Colors.amber.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ShimmerCarouselBooks extends StatelessWidget {
  const ShimmerCarouselBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Shimmer untuk gambar latar belakang
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.grey.shade300,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        // Shimmer untuk overlay (jika diperlukan)
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Shimmer untuk teks
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder untuk judul
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: Get.width * 0.7,
                    height: 18,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Placeholder untuk deskripsi
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: Get.width * 0.65,
                    height: 60,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Placeholder untuk tanggal
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: Get.width * 0.4,
                    height: 14,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}