import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/form_helper/doc_cubit/document_cubit.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import '../../profile/screen/doc_list_tile.dart';
import '../../routing/route_path.dart';
import '../../utils/images.dart';
import '../../widgets/information_widgets/info_title_widget.dart';

class ReqDocumentScreen extends StatefulWidget {
  const ReqDocumentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ReqDocumentScreen> createState() => _ReqDocumentScreenState();
}

class _ReqDocumentScreenState extends State<ReqDocumentScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = DocumentCubit.get(context);
    cubit.getAccomodationType();
    cubit.getDocAddType();
  }

  @override
  Widget build(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: const InfoCustomAppBar(),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            var data = state.profileModal.responseData;
            return RefreshIndicator(
              onRefresh: () {
                var cubit = ProfileCubit.get(context);
                return cubit.getProfile();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20, bottom: 20),
                child: ListView(
                  children: [
                    const InfoTitleWidget(
                      title: MyWrittenText.reqDocumentTitleText,
                      subtitle: MyWrittenText.reqDocumentSubTitleText,
                      height: 90,
                    ),
                    SizedBox(height: 20.h),
                    DocumentListTile(
                      image: MyImages.aadhaarCardImage,
                      showIndicator: data!.idproofverify!,
                      title: MyWrittenText.aadhaarCardText,
                      onTap: () {
                        if (data.idproofverify!) {
                          Navigator.pushNamed(context, RoutePath.aadhaarCardScreen, arguments: () {
                            profileCubit.getProfile();
                          });
                        } else {
                          Navigator.pushNamed(context, RoutePath.aadhaarViewScreen);
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    DocumentListTile(
                        image: MyImages.panCardImage,
                        showIndicator: data.pancardFileverify!,
                        title: MyWrittenText.panCardNoText,
                        onTap: () {
                          if (data.pancardFileverify!) {
                            Navigator.pushNamed(context, RoutePath.panCardScreen, arguments: () {
                              profileCubit.getProfile();
                            });
                          } else {
                            Navigator.pushNamed(context, RoutePath.panCardViewScreen);
                          }
                        }),
                    SizedBox(height: 15.h),
                    DocumentListTile(
                        image: MyImages.residentImage,
                        showIndicator: data.addressProofVerify!,
                        title: MyWrittenText.addProofText,
                        onTap: () {
                          if (data.addressProofVerify!) {
                            Navigator.pushNamed(context, RoutePath.addressProofScreen, arguments: () {
                              profileCubit.getProfile();
                            });
                          } else {
                            Navigator.pushNamed(context, RoutePath.addressProofViewScreen);
                          }
                        }),
                    SizedBox(height: 15.h),
                    DocumentListTile(
                        image: MyImages.accomodation2,
                        showIndicator: data.aggrementVerify!,
                        title: MyWrittenText.accommodationText,
                        onTap: () {
                          if (data.aggrementVerify!) {
                            Navigator.pushNamed(context, RoutePath.accommodationScreen, arguments: () {
                              profileCubit.getProfile();
                            });
                          } else {
                            Navigator.pushNamed(context, RoutePath.accommodationViewScreen);
                          }
                        }),
                    SizedBox(height: 15.h),
                    DocumentListTile(
                        image: MyImages.salarySlipImage,
                        showIndicator: data.salaryVerifyFile!,
                        title: MyWrittenText.salarySlipText,
                        onTap: () {
                          Navigator.pushNamed(context, RoutePath.salarySlipScreen, arguments: () {
                            profileCubit.getProfile();
                          });
                        }),
                    SizedBox(height: 15.h),
                    DocumentListTile(
                        image: MyImages.statementImage,
                        showIndicator: data.bankVerify!,
                        title: MyWrittenText.bankStatementText,
                        onTap: () {
                          Navigator.pushNamed(context, RoutePath.bankStatementScreen, arguments: () {
                            profileCubit.getProfile();
                          });
                        }),
                  ],
                ),
              ),
            );
          } else {
            return const MyLoader();
          }
        },
      ),
    );
  }
}
