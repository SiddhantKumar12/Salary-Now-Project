import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/permission_handler/cubit/launguage_cubit/launguage_cubit.dart';
import 'package:salarynow/permission_handler/screens/permission_card_widget.dart';
import 'package:salarynow/permission_handler/screens/permission_web_view.dart';
import 'package:salarynow/routing/route_path.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../bottom_nav_bar/screen/bottom_nav.dart';
import '../../storage/local_storage.dart';
import '../../storage/local_storage_strings.dart';
import '../../utils/color.dart';
import '../../utils/icons.dart';

class PermissionScreen extends StatefulWidget {
  final bool beforeRegistration;

  const PermissionScreen({Key? key, required this.beforeRegistration}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool isPrivatePolicy = false;
  bool isLanguageAccept = false;

  @override
  void initState() {
    super.initState();
    if (widget.beforeRegistration) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => launguageDialogBox(context: context, isLanguage: isLanguageAccept));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const InfoCustomAppBar(
            title: MyWrittenText.permissionText,
            leading: null,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: MyText(
                      text: MyWrittenText.permissionSubText,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w300,
                      color: MyColor.subtitleTextColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
                    child: Column(
                      children: [
                        const PermissionCardWidget(
                          title: MyWrittenText.callLogText,
                          subTitle: MyWrittenText.callLogSubText,
                          image: MyIcons.phoneCall,
                        ),
                        const PermissionCardWidget(
                          title: MyWrittenText.smsText,
                          subTitle: MyWrittenText.callLogSubText,
                          image: MyIcons.chatIcon,
                        ),
                        const PermissionCardWidget(
                          title: 'Camera',
                          subTitle: MyWrittenText.callLogSubText,
                          image: MyIcons.cameraIcon,
                        ),
                        const PermissionCardWidget(
                          title: MyWrittenText.imeiText,
                          subTitle: MyWrittenText.callLogSubText,
                          image: MyIcons.imei,
                        ),
                        const PermissionCardWidget(
                          title: MyWrittenText.phoneText,
                          subTitle: MyWrittenText.callLogSubText,
                          image: MyIcons.mobileAppIcon,
                        ),
                        const PermissionCardWidget(
                          title: MyWrittenText.locationText,
                          subTitle: MyWrittenText.locationSubText,
                          image: MyIcons.mapIcon,
                        ),
                        const PermissionCardWidget(
                          title: MyWrittenText.storageText,
                          subTitle: MyWrittenText.storageSubText,
                          image: MyIcons.memoryCard,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                          color: MyColor.containerBGColor,
                          width: double.infinity,
                          child: const MyText(text: MyWrittenText.dataEncryptText),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: widget.beforeRegistration ? 2 : 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: MyColor.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 5.0,
                        spreadRadius: 3, //New
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      widget.beforeRegistration
                          ? Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                                    ),
                                    child: SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: Checkbox(
                                          value: isPrivatePolicy,
                                          onChanged: (value) {
                                            setState(() {
                                              isPrivatePolicy = value!;
                                            });
                                          },
                                        )),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (isPrivatePolicy) {
                                        isPrivatePolicy = false;
                                      } else {
                                        isPrivatePolicy = true;
                                      }
                                      setState(() {});
                                    },
                                    child: MyText(
                                        text: 'I have read and accept the ',
                                        color: MyColor.blackColor,
                                        fontSize: 15.sp)),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => const PermissionWebView()));
                                    },
                                    child:
                                        MyText(text: 'Privacy Policy', color: MyColor.turcoiseColor, fontSize: 15.sp),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Row(
                        children: [
                          Expanded(
                            child: MyButton(
                              text: widget.beforeRegistration ? MyWrittenText.denyyText : 'Skip For Now',
                              onPressed: () {
                                if (widget.beforeRegistration) {
                                  MyDialogBox.showPermissionDialog(context);
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const CustomBottomNavBar()),
                                      (route) => false);
                                }
                              },
                              borderSide: const BorderSide(color: MyColor.subtitleTextColor),
                              buttonColor: MyColor.whiteColor,
                              textColor: MyColor.subtitleTextColor,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                              child: MyButton(
                                  text: widget.beforeRegistration ? MyWrittenText.iAgreeText : 'Allow',
                                  onPressed: () {
                                    if (widget.beforeRegistration == true) {
                                      if (isPrivatePolicy) {
                                        MyStorage.writeData(MyStorageString.isUserOnBoard, true);
                                        Navigator.pushReplacementNamed(context, RoutePath.loginScreen);
                                      } else {
                                        MySnackBar.showSnackBar(context, 'Please accept Privacy Policy');
                                      }
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => const CustomBottomNavBar()),
                                          (route) => false);
                                    }
                                  })),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  static launguageDialogBox({
    required BuildContext context,
    required bool isLanguage,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: BlocProvider(
            create: (context) => LanguageCubit(),
            child: BlocConsumer<LanguageCubit, LanguageState>(
              listener: (context, state) {
                if (state is LanguageLoading) {
                  MyScreenLoader.onScreenLoader(context);
                }
                if (state is LanguageLoaded) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                if (state is LanguageError) {
                  Navigator.pop(context);
                  MySnackBar.showSnackBar(context, state.error);
                }
              },
              builder: (context, state) {
                return StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        MyText(
                          text: MyWrittenText.engLanguageSubtitle,
                          fontSize: 15.sp,
                        ),
                        SizedBox(height: 16.h), // Add some spacing
                        GestureDetector(
                          onTap: () {
                            if (isLanguage) {
                              isLanguage = false;
                            } else {
                              isLanguage = true;
                            }
                            setState(() {});
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor: MyColor.blackColor.withOpacity(0.5), // Your color
                                      ),
                                      child: SizedBox(
                                          height: 20.h,
                                          width: 20.w,
                                          child: Checkbox(
                                            value: isLanguage,
                                            onChanged: (value) {
                                              setState(() {
                                                isLanguage = value!;
                                              });
                                            },
                                          )),
                                    ),
                                  ),
                                  SizedBox(height: 40.h),
                                  MyText(
                                    text: 'I agree with the above',
                                    color: MyColor.blackColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: MyButton(
                                      text: MyWrittenText.denyText,
                                      onPressed: () {
                                        FlutterExitApp.exitApp();
                                      },
                                      borderSide: const BorderSide(color: MyColor.subtitleTextColor),
                                      buttonColor: MyColor.whiteColor,
                                      textColor: MyColor.subtitleTextColor,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                      child: MyButton(
                                          text: MyWrittenText.iAgreeText,
                                          onPressed: () {
                                            if (isLanguage) {
                                              LanguageCubit.get(context).postLanguage(language: 'en');
                                              // Navigator.pop(context);
                                            } else {
                                              MySnackBar.showSnackBar(context, 'Please Accept Language');
                                            }
                                          })),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        );
      },
    );
  }
}
