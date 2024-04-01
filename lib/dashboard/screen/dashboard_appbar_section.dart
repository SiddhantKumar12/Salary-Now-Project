import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../required_document/network/modal/selfie_modal.dart';
import '../../routing/route_path.dart';
import '../../utils/color.dart';
import '../../utils/written_text.dart';
import '../../widgets/loader.dart';
import '../../widgets/profile_avatar.dart';
import '../../widgets/text_widget.dart';
import '../cubit/get_selfie_cubit/get_selfie_cubit.dart';

class DashBoardAppBarSection extends StatelessWidget {
  const DashBoardAppBarSection({
    super.key,
    required this.selfieModal,
  });

  final SelfieModal? selfieModal;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, top: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: Builder(builder: (context) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: BlocBuilder<GetSelfieCubit, GetSelfieState>(
                                builder: (context, state) {
                                  if (state is GetSelfieLoaded) {
                                    return state.modal.data!.front!.isNotEmpty
                                        ? Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50.r),
                                                border: Border.all(color: MyColor.turcoiseColor, width: 3.w)),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(48.r),
                                              child: CachedNetworkImage(
                                                height: 70.h,
                                                width: 70.h,
                                                imageUrl: state.modal.data!.front!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) => const MyLoader(),
                                                errorWidget: (context, url, error) =>
                                                    SizedBox(height: 70.h, width: 70.h, child: const Icon(Icons.error)),
                                              ),
                                            ),
                                          )
                                        : const MyProfileAvatar();
                                  } else {
                                    return const MyProfileAvatar();
                                  }
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Builder(builder: (context) {
                                return Transform.translate(
                                  offset: Offset(13.w, -3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          spreadRadius: 2,
                                          color: MyColor.subtitleTextColor.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                        radius: 16.r,
                                        backgroundColor: MyColor.whiteColor,
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            Scaffold.of(context).openDrawer();
                                          },
                                          icon: Icon(
                                            Icons.menu,
                                            size: 24.sp,
                                            color: MyColor.blackColor,
                                          ),
                                        )),
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(width: 23.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: MyWrittenText.welcomeText,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                        BlocBuilder<GetSelfieCubit, GetSelfieState>(
                          builder: (context, state) {
                            if (state is GetSelfieLoaded) {
                              return SizedBox(
                                width: 250.w,
                                child: MyText(
                                  text: state.modal.data?.fullname?.toUpperCase() ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  textOverflow: TextOverflow.ellipsis,
                                  color: MyColor.turcoiseColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              );
                            } else {
                              return SizedBox(
                                width: 250.w,
                                child: MyText(
                                  text: selfieModal?.data?.fullname?.toUpperCase() != null
                                      ? selfieModal!.data!.fullname!.toUpperCase()
                                      : '',
                                  overflow: TextOverflow.ellipsis,
                                  color: MyColor.turcoiseColor,
                                  textOverflow: TextOverflow.ellipsis,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePath.navigation);
                  },
                  icon: Stack(
                    children: <Widget>[
                      Icon(
                        Icons.notifications_outlined,
                        size: 35.sp,
                        color: MyColor.blackColor,
                      ),
                      // Positioned(
                      //   right: 0,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(1),
                      //     decoration: BoxDecoration(
                      //       color: Colors.grey,
                      //       borderRadius: BorderRadius.circular(6),
                      //     ),
                      //     constraints: const BoxConstraints(
                      //       minWidth: 12,
                      //       minHeight: 12,
                      //     ),
                      //     child: const Text(
                      //       '0',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 8,
                      //       ),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
