import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salarynow/dashboard/network/modal/carousel_slider_modal.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/color.dart';
import '../../widgets/loader.dart';

class MyCarouselSlider extends StatefulWidget {
  final CarouselSliderModal carouselSliderModal;

  const MyCarouselSlider({super.key, required this.carouselSliderModal});
  @override
  MyCarouselSliderState createState() => MyCarouselSliderState();
}

class MyCarouselSliderState extends State<MyCarouselSlider> {
  final PageController _pageController = PageController();

  int currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < widget.carouselSliderModal.responseData!.bannerCount!) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(currentPage, duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.carouselSliderModal.responseData;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: data?.bannerCount,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: data?.banners![index].toString() ?? '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const MyLoader(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                );
              },
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: data?.bannerCount ?? 0,
              effect: ExpandingDotsEffect(
                dotHeight: 12.h,
                dotWidth: 12.w,
                // radius: 10.r,
                spacing: 10.w,
                activeDotColor: MyColor.turcoiseColor,
                dotColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
