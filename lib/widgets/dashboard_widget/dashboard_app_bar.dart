import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/storage/local_user_modal.dart';
import '../../storage/local_storage.dart';
import '../../utils/color.dart';
import '../profile_avatar.dart';
import '../text_widget.dart';

class DashBoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  DashBoardAppBar({
    super.key,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  final LocalUserModal? localUserModal = MyStorage.getUserData();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 400.h,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipPath(
        clipper: CustomShape(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: MyColor.blackColor,
                  spreadRadius: -10.0,
                  blurRadius: 20.0,
                )
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff7565A5),
                  MyColor.turcoiseColor,
                ],
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.menu,
                          color: MyColor.whiteColor,
                          size: 40.h,
                        ),
                      );
                    }),
                    IconButton(
                      onPressed: () {},
                      icon: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            size: 40.h,
                            color: MyColor.whiteColor,
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: const Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const MyProfileAvatar(),
                      SizedBox(height: 15.h),
                      MyText(
                        text: localUserModal!.responseData!.name!,
                        fontSize: 25.sp,
                        color: MyColor.whiteColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            size: 18.h,
                            color: MyColor.whiteColor,
                          ),
                          SizedBox(width: 7.w),
                          MyText(
                            text: localUserModal!.responseData!.email!,
                            fontSize: 16.sp,
                            color: MyColor.whiteColor,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone,
                            size: 18.h,
                            color: MyColor.whiteColor,
                          ),
                          SizedBox(width: 7.w),
                          MyText(
                            text: localUserModal!.responseData!.mobile!,
                            fontSize: 16.sp,
                            color: MyColor.whiteColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height - 100);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
