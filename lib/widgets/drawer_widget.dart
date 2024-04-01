import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/widgets/profile_avatar.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../dashboard/cubit/get_selfie_cubit/get_selfie_cubit.dart';
import '../required_document/network/modal/selfie_modal.dart';
import '../routing/route_path.dart';
import '../storage/local_storage.dart';
import '../storage/local_user_modal.dart';
import '../utils/color.dart';
import 'loader.dart';

class MyDrawer extends StatelessWidget {
  SelfieModal? selfieModal = MyStorage.getSelfieData();

  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // padding: EdgeInsets.only(top: 20.h),
        children: <Widget>[
          Container(
            height: 200.h,
            color: MyColor.turcoiseColor.withOpacity(0.8),
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 15.w, bottom: 15.h, top: 15.h),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: Icon(
                            Icons.close,
                            size: 30.sp,
                            color: MyColor.whiteColor,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 80.h,
                    width: 80.h,
                    child: BlocBuilder<GetSelfieCubit, GetSelfieState>(
                      builder: (context, state) {
                        if (state is GetSelfieLoaded) {
                          return state.modal.data!.front!.isNotEmpty
                              ? Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r),
                                      border: Border.all(color: MyColor.whiteColor, width: 3.w)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(48.r),
                                    child: CachedNetworkImage(
                                      imageUrl: state.modal.data!.front!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const MyLoader(),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  SizedBox(height: 20.w),
                  BlocBuilder<GetSelfieCubit, GetSelfieState>(
                    builder: (context, state) {
                      if (state is GetSelfieLoaded) {
                        return MyText(
                          textOverflow: TextOverflow.ellipsis,
                          text: state.modal.data?.fullname?.toUpperCase() ?? '',
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18.sp,
                          color: MyColor.whiteColor,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          maxLines: 1,
                        );
                      } else {
                        return MyText(
                          textOverflow: TextOverflow.ellipsis,
                          text: selfieModal?.data?.fullname?.toUpperCase() != null
                              ? selfieModal!.data!.fullname!.toUpperCase()
                              : '',
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18.sp,
                          color: MyColor.whiteColor,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          maxLines: 1,
                        );
                      }
                    },
                  ),
                ]),
          ),
          SizedBox(height: 20.h),
          buildListTile(
            context: context,
            title: 'Home',
            onPressed: () => Navigator.pop(context),
            icon: Icons.home,
          ),
          buildListTile(
            context: context,
            title: 'Clear Cache',
            onPressed: () async {
              await _deleteCacheDir().whenComplete(() => Navigator.pop(context));
              MySnackBar.showSnackBar(context, 'Cache Cleared');
            },
            icon: Icons.delete,
          ),
          buildListTile(
            context: context,
            title: 'Contact Us',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, RoutePath.dashBoardContactUsScreen);
            },
            icon: Icons.phone,
          ),
        ],
      ),
    );
  }

  // ListTile buildListTile(
  //     {required BuildContext context, required IconData icon, required String title, required VoidCallback onPressed}) {
  //   return ListTile(
  //     leading: Icon(icon),
  //     title: Transform.translate(offset: Offset(-15.w, 0), child: MyText(text: title)),
  //     onTap: onPressed,
  //   );
  // }

  GestureDetector buildListTile(
      {required BuildContext context, required IconData icon, required String title, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        width: double.maxFinite,
        child: Row(
          children: [
            Icon(
              icon,
              color: MyColor.turcoiseColor,
            ),
            SizedBox(width: 15.w),
            MyText(text: title),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }

    // Future<void> _deleteAppDir() async {
    //   final appDir = await getApplicationSupportDirectory();
    //
    //   if (appDir.existsSync()) {
    //     appDir.deleteSync(recursive: true);
    //   }
    // }
  }
}
