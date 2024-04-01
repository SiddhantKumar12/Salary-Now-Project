import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:salarynow/form_helper/form_helper_cubit/form_helper_cubit.dart';
import 'package:salarynow/profile/cubit/cancel_mandate/cancel_mandate_cubit.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/routing/route_path.dart';
import 'package:salarynow/utils/on_screen_loader.dart';
import 'package:salarynow/utils/snackbar.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/elevated_button_widget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../bottom_nav_bar/cubit/navbar_cubit.dart';
import '../../information/screens/residential_screen/govt_aadhaar_card_verify/govt_aadhar_card.dart';
import '../../packages/cubit/packages_cubit/packages_cubit.dart';
import '../../storage/local_storage.dart';
import '../../utils/color.dart';
import '../../utils/images.dart';
import 'doc_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CancelMandateCubit? cancelMandateCubit;

  final TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var cubit = FormHelperApiCubit.get(context);
    var profileCubit = ProfileCubit.get(context);
    cancelMandateCubit = CancelMandateCubit.get(context);
    profileCubit.getProfile();
    cubit.getUserCommonList();
    cubit.getState();
    cubit.getSalaryModeList();
    cubit.getEmploymentType();
  }

  @override
  void dispose() {
    cancelMandateCubit?.close();
    remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(
        leading: true,
        popScreen: false,
        title: MyWrittenText.myProfileText,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            if (state is PackagesErrorState) {
              if (state.error == MyWrittenText.unauthorizedAccess) {
                MyStorage.cleanAllLocalStorage();
                FlutterExitApp.exitApp();
              }
            }
            // MySnackBar.showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoaded) {
            var data = state.profileModal.responseData;
            return RefreshIndicator(
              onRefresh: () {
                var cubit = ProfileCubit.get(context);
                return cubit.getProfile();
              },
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                children: [
                  DocumentListTile(
                      image: MyImages.personalImage,
                      title: MyWrittenText.personalDetailText,
                      onTap: () {
                        if (data.personal! || data.selfi!) {
                          Navigator.pushNamed(context, RoutePath.personalScreen);
                        } else {
                          Navigator.pushNamed(context, RoutePath.personalViewScreen);
                        }
                      },
                      showIndicator: data!.personal!),
                  SizedBox(height: 15.h),
                  DocumentListTile(
                      image: MyImages.professionalImage,
                      title: MyWrittenText.professionalDetailText,
                      showIndicator: data.employeement!,
                      onTap: () {
                        if (data.employeement!) {
                          Navigator.pushNamed(context, RoutePath.professionalScreen);
                        } else {
                          Navigator.pushNamed(context, RoutePath.professionalViewScreen);
                        }
                      }),
                  SizedBox(height: 15.h),
                  DocumentListTile(
                      image: MyImages.residentialImage,
                      title: MyWrittenText.residentialDetailText,
                      showIndicator: state.profileModal.responseData!.residential!,
                      onTap: () {
                        if (data.residential!) {
                          if (data.govtAadhar == true) {
                            Navigator.pushNamed(context, RoutePath.govtAadhaarScreen, arguments: {
                              'isApplyScreen': false,
                              'isDashBoardScreen': false,
                            });
                          } else {
                            Navigator.pushNamed(context, RoutePath.residentialScreen);
                          }
                        } else {
                          Navigator.pushNamed(context, RoutePath.residentialViewScreen);
                        }
                      }),
                  SizedBox(height: 15.h),
                  DocumentListTile(
                      image: MyImages.bankImage,
                      showIndicator: state.profileModal.responseData!.bank!,
                      title: MyWrittenText.bankDetailsText,
                      onTap: () {
                        if (data.bank!) {
                          Navigator.pushNamed(context, RoutePath.bankScreen);
                        } else {
                          Navigator.pushNamed(context, RoutePath.bankViewScreen);
                        }
                      }),
                  SizedBox(height: 15.h),
                  DocumentListTile(
                      image: MyImages.docImage,
                      isDocument: true,
                      showIndicator: true,
                      title: MyWrittenText.documentText,
                      onTap: () {
                        Navigator.pushNamed(context, RoutePath.reqDocumentScreen);
                      }),
                  SizedBox(height: 100.h),
                  BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoaded) {
                        return state.dashBoardModal.responseData?.mandatecancelbtn == true
                            ? BlocListener<CancelMandateCubit, CancelMandateState>(
                                listener: (context, state) {
                                  if (state is CancelMandateLoading) {
                                    MyScreenLoader.onScreenLoader(context);
                                  }
                                  if (state is CancelMandateLoaded) {
                                    Navigator.pop(context);
                                    MyDialogBox.cancelMandate(context: context);
                                  }
                                  if (state is CancelMandateError) {
                                    Navigator.pop(context);
                                    MySnackBar.showSnackBar(context, state.error);
                                  }
                                },
                                child: Column(
                                  children: [
                                    MyButton(
                                      text: 'Cancel E-Mandate',
                                      onPressed: () {
                                        MyDialogBox.remarksCancelMandate(
                                            loanNumber: state.dashBoardModal.responseData!.loanDetails!.applicationNo!,
                                            context: context,
                                            textEditingController: remarksController,
                                            cancelMandateCubit: cancelMandateCubit);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  )
                ],
              ),
            );
          } else if (state is ProfileLoading) {
            return const MyLoader();
          } else {
            return MyErrorWidget(
              onPressed: () {
                var cubit = ProfileCubit.get(context);
                var formCubit = FormHelperApiCubit.get(context);
                cubit.getProfile();
                formCubit.getUserCommonList();
              },
            );
          }
        },
      ),
    );
  }
}
