import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/boarding/cubit/on_boarding_cubit.dart';
import 'package:salarynow/boarding/cubit/save_common_id/save_common_id_cubit.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/on_board_listPages.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../routing/route_path.dart';
import '../../widgets/elevated_button_widget.dart';
import 'on_boarding_pages.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = [
    OnBoardPages(
      title: onBoardData[0].title,
      subtitle: onBoardData[0].description,
      image: onBoardData[0].imgUrl,
    ),
    OnBoardPages(
      title: onBoardData[1].title,
      subtitle: onBoardData[1].description,
      image: onBoardData[1].imgUrl,
    ),
    OnBoardPages(title: onBoardData[2].title, subtitle: onBoardData[2].description, image: onBoardData[2].imgUrl),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          var onBoardCubit = OnBoardingCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    height: 100.h,
                    padding: EdgeInsets.only(right: 20.w),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: onBoardCubit.currentIndex == 2
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  var commonIdCubit = SaveCommonIdCubit.get(context);
                                  commonIdCubit.postCommonID();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: MyColor.turcoiseColor),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: MyText(
                                    text: MyWrittenText.skipText,
                                    fontSize: 18.sp,
                                    // fontWeight: FontWeight.w300,
                                    color: MyColor.turcoiseColor,
                                  ),
                                ),
                              )),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            onBoardCubit.changePage(index);
                          },
                          itemCount: _pages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _pages[index % _pages.length];
                          },
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 270.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 135.w),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _pages.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.white,
                                              onTap: () {
                                                _pageController.animateToPage(index,
                                                    duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                child: CircleAvatar(
                                                  radius: 8.r,
                                                  backgroundColor: onBoardCubit.currentIndex == index
                                                      ? MyColor.blackColor
                                                      : MyColor.blackColor.withOpacity(0.3),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                  BlocListener<SaveCommonIdCubit, SaveCommonIdState>(
                                    listener: (context, state) {
                                      if (state is SaveCommonIdLoading) {
                                        MyScreenLoader.onScreenLoader(context);
                                      }
                                      if (state is SaveCommonIdLoaded) {
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(context, RoutePath.permissionScreen,
                                            arguments: true);
                                      }
                                      if (state is SaveCommonIdError) {
                                        Navigator.pop(context);
                                        MySnackBar.showSnackBar(context, state.error);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 50),
                                      child: MyButton(
                                        onPressed: () {
                                          if (onBoardCubit.currentIndex == 2) {
                                            var commonIdCubit = SaveCommonIdCubit.get(context);
                                            commonIdCubit.postCommonID();
                                          } else {
                                            _pageController.animateToPage(onBoardCubit.currentIndex + 1,
                                                duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                                          }
                                        },
                                        text: onBoardCubit.currentIndex == 2
                                            ? MyWrittenText.getStartedText
                                            : MyWrittenText.continueText,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
