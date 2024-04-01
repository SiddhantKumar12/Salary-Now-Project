import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salarynow/Notification/cubit/post_fcm_token_cubit.dart';
import 'package:salarynow/dashboard/cubit/app_version_cubit/app_version_cubit.dart';
import 'package:salarynow/dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:salarynow/dashboard/cubit/get_selfie_cubit/get_selfie_cubit.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/check_micro_user/check_micro_user_cubit.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/update_micro_status/update_micro_status_cubit.dart';
import 'package:salarynow/dashboard/network/modal/dashboard_modal.dart';
import 'package:salarynow/dashboard/screen/dashBoard_approved.dart';
import 'package:salarynow/dashboard/screen/dashboard_disbursed.dart';
import 'package:salarynow/dashboard/screen/dashboard_under_verify.dart';
import 'package:salarynow/dashboard/screen/drawer/drawer_widget.dart';
import 'package:salarynow/dashboard/screen/rejection_screen.dart';
import 'package:salarynow/permission_handler/cubit/location_cubit/location_tracker_cubit.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/repayment/cuibt/repayment/repayment_cubit.dart';
import 'package:salarynow/required_document/network/modal/selfie_modal.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/loader.dart';

import '../../bottom_nav_bar/cubit/navbar_cubit.dart';
import '../../internet_connection/no_internet_screen.dart';
import '../../routing/route_path.dart';
import '../../storage/local_storage.dart';
import '../../storage/local_storage_strings.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';
import '../../utils/written_text.dart';
import '../../widgets/text_widget.dart';
import '../cubit/carousel_slider_cubit/carousel_slider_cubit.dart';
import 'carousel_slider.dart';
import 'dashboard_appbar_section.dart';
import 'dashboard_initial_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with WidgetsBindingObserver {
  Future callApi() async {
    context.read<DashboardCubit>().getAppVersion();
  }

  SelfieModal? selfieModal = MyStorage.getSelfieData();
  bool isLoading = false;
  String? fcmToken;
  bool isNormalUser = true;
  var ctime;

  @override
  void initState() {
    callApi();
    super.initState();
    fcmToken = MyStorage.readData(MyStorageString.fcmToken);
    if (fcmToken != null) {
      PostFcmTokenCubit.get(context).postFcm(fcmToken!);
    }
    _initialReload();
  }

  @override
  Widget build(BuildContext context) {
    // var cubit = context.read<DashboardCubit>().getAppVersion();
    var cubit = context.read<DashboardCubit>();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          var cubit = NavbarCubit.get(context);
          if (cubit.currentIndex == 1 ||
              cubit.currentIndex == 2 ||
              cubit.currentIndex == 3 ||
              cubit.currentIndex == 4) {
            cubit.changeBottomNavBar(0);
            print('go to homeScreen');
            return false;
          } else {
            DateTime now = DateTime.now();
            if (ctime == null || now.difference(ctime) > Duration(seconds: 2)) {
              ctime = now;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: MyColor.turcoiseColor,
                  content:
                      Text('Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
              return Future.value(false);
            }

            return Future.value(true);
          }
        },
        child: Scaffold(
          drawer: MyDrawer(
            version: cubit.appVersion,
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<DashboardCubit, DashboardState>(listener: (context, state) {
                if (state is DashboardLoaded) {
                  if (state.dashBoardModal.responseData?.rejectStatus == '1') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RejectionScreen(
                                  text: state.dashBoardModal.responseData?.rejectMsg ?? '',
                                  days: state.dashBoardModal.responseData?.rejectDays.toString() ?? '',
                                )));
                  }

                  if (state.dashBoardModal.responseData?.loctionApi == true) {
                    var locationCubit = LocationTrackerCubit.get(context);
                    locationCubit.postLocation(
                      loanNumber: state.dashBoardModal.responseData!.loanDetails!.applicationNo!,
                    );
                  }
                }
                if (state is DashboardError) {
                  if (state.error == MyWrittenText.unauthorizedAccess) {
                    MyStorage.cleanAllLocalStorage();
                    FlutterExitApp.exitApp();
                  } else if (state.error == MyWrittenText.noInternet) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NoInternetScreen()));
                  } else {
                    MySnackBar.showSnackBar(context, state.error.toString());
                  }
                }
              }),

              /// Micro user Check
              BlocListener<CheckMicroUserCubit, CheckMicroUserState>(
                listener: (context, state) {
                  if (state is CheckMicroUserLoaded) {
                    if (state.checkMicroUserModal.responseData == true) {
                      MyDialogBox.salaryConfirmation(context: context, onPressed: () {}, isNormalUser: isNormalUser);
                    }
                  }
                },
              ),
              BlocListener<UpdateMicroStatusCubit, UpdateMicroStatusState>(
                listener: (context, state) {
                  if (state is UpdateMicroStatusLoading) {
                    MyScreenLoader.onScreenLoader(context);
                  }
                  if (state is UpdateMicroStatusLoaded) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.updateMicroStatusModal.responseMsg!);
                  }
                  if (state is UpdateMicroStatusError) {
                    Navigator.pop(context);
                    MySnackBar.showSnackBar(context, state.error);
                  }
                },
                child: const SizedBox.shrink(),
              ),

              /// App Version
              BlocListener<AppVersionCubit, AppVersionState>(listener: (context, state) {
                if (state is AppVersionLoaded) {
                  if (state.appVersionModal.responseData!.serverversion! == state.appVersion) {
                    MyDialogBox.appUpdateDialogBox(
                      context: context,
                      appVersion: state.appVersion,
                    );
                  }
                }
              }),
            ],
            child: Column(
              children: [
                DashBoardAppBarSection(selfieModal: selfieModal),
                Expanded(
                  flex: 8,
                  child: isLoading
                      ? RefreshIndicator(
                          onRefresh: () {
                            return _refreshData();
                          },
                          child: ListView(
                            children: [
                              SizedBox(height: 30.h),
                              BlocBuilder<CarouselSliderCubit, CarouselSliderState>(
                                builder: (context, state) {
                                  if (state is CarouselSliderLoaded) {
                                    var data = state.carouselSliderModal.responseData;
                                    return data?.bannerStatus == true
                                        ? MyCarouselSlider(carouselSliderModal: state.carouselSliderModal)
                                        : const SizedBox();
                                  }
                                  return const SizedBox();
                                },
                              ),
                              BlocBuilder<DashboardCubit, DashboardState>(
                                builder: (context, state) {
                                  if (state is DashboardLoaded) {
                                    var data = state.dashBoardModal;
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: getWidget(
                                              state.dashBoardModal.responseData!.loanDetails!.loanstatus!, data),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context, RoutePath.dashBoardContactUsScreen);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  const MyText(text: MyWrittenText.helloText),
                                                  SvgPicture.asset(
                                                    MyImages.supportIcon,
                                                    fit: BoxFit.fitHeight,
                                                    height: 80.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                      ],
                                    );
                                  } else if (state is DashboardLoading) {
                                    return SizedBox(
                                        height: 400.h,
                                        child: const Center(
                                          child: MyLoader(),
                                        ));
                                  } else if (state is DashboardError) {
                                    return SizedBox(
                                      height: 428.h,
                                      child: MyErrorWidget(onPressed: () async {
                                        _refreshData();
                                      }),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ],
                          ),
                        )
                      : const MyLoader(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getWidget(String value, DashBoardModal dashBoardModal) {
    switch (value) {
      case '0':

        /// Pending
        return DashBoardUnderVerifyWidget(dashBoardModal: dashBoardModal);
      case '1':

        /// Approved
        return DashBoardApprovedScreen(dashBoardModal: dashBoardModal);
      case '2':

        /// Disbursed
        return DashBoardDisbursedScreen(dashBoardModal: dashBoardModal);
      case '3':

        /// Close
        return const DashBoardInitialWidget();
      case '4':

        /// Reject
        return const DashBoardInitialWidget();
      case '5':

        /// Not Interested
        return const DashBoardInitialWidget();

      case '7':

        /// Part Payment
        /// change the heading tile to part payment and container color is blue
        return DashBoardDisbursedScreen(dashBoardModal: dashBoardModal);

      case '8':

        /// Disbursed Initiated
        return DashBoardDisbursedScreen(dashBoardModal: dashBoardModal);
      default:
        return const DashBoardInitialWidget();
    }
  }

  Future<void> _initialReload() async {
    try {
      var selfieCubit = GetSelfieCubit.get(context);
      var dashBoardCubit = DashboardCubit.get(context);
      var sliderCubit = CarouselSliderCubit.get(context);
      await CheckMicroUserCubit.get(context).getCheckMicro();
      await dashBoardCubit.getDashBoardData();
      await selfieCubit.getSelfie(doctype: 'selfie');
      await sliderCubit.getCarouselUrl();
    } catch (e) {
      rethrow;
    }

    setState(() {
      isLoading = true;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = false;
    });

    fcmToken = MyStorage.readData(MyStorageString.fcmToken);
    if (fcmToken != null) {
      PostFcmTokenCubit.get(context).postFcm(fcmToken!);
    }

    var selfieCubit = GetSelfieCubit.get(context);
    var dashBoardCubit = DashboardCubit.get(context);
    var sliderCubit = CarouselSliderCubit.get(context);
    var repayCubit = RepaymentCubit.get(context);
    var profileCubit = ProfileCubit.get(context);

    try {
      await CheckMicroUserCubit.get(context).getCheckMicro();
      await selfieCubit.getSelfie(doctype: 'selfie');
      await sliderCubit.getCarouselUrl();
      await dashBoardCubit.getDashBoardData();
      await repayCubit.getRepayment();
      await profileCubit.getProfile();
    } catch (e) {
      rethrow;
    }

    setState(() {
      isLoading = true;
    });
  }
}
