import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salarynow/required_document/cubit/get_doc_cubit/get_document_cubit.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import '../../routing/route_path.dart';
import '../../utils/color.dart';
import '../../widgets/list_tile_widget.dart';
import '../../widgets/loader.dart';
import '../../widgets/text_widget.dart';

class SalarySlipScreen extends StatefulWidget {
  final Function? refreshProfile;

  const SalarySlipScreen({Key? key, this.refreshProfile}) : super(key: key);
  @override
  State<SalarySlipScreen> createState() => _SalarySlipScreenState();
}

class _SalarySlipScreenState extends State<SalarySlipScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = GetDocumentCubit.get(context);
    cubit.getDocument(doctype: 'salary_slip');
  }

  Function(String)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 2),
      body: BlocBuilder<GetDocumentCubit, GetDocumentState>(
        builder: (context, state) {
          if (state is SalarySlipLoaded) {
            var data = state.modal.data!;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 30.w),
              child: Column(children: [
                const InfoTitleWidget(
                  title: MyWrittenText.salarySlipText,
                  subtitle: MyWrittenText.salarySlipSubtitleText,
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return MyListTile(
                      trailing: data[index].status!
                          ? Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor: MyColor.greenColor,
                                child: Icon(
                                  Icons.done,
                                  size: 24.sp,
                                  color: MyColor.whiteColor,
                                ),
                              ),
                            )
                          : const Icon(
                              Icons.arrow_forward_ios,
                              color: MyColor.turcoiseColor,
                            ),
                      title: data[index].month ?? '',
                      onTap: () {
                        if (data[index].status == false) {
                          Navigator.pushNamed(context, RoutePath.salarySlipMonthScreen, arguments: {
                            'refreshProfile': () {
                              widget.refreshProfile!();
                            },
                            'title': data[index].month ?? '',
                          });
                        }
                      },
                    );
                  },
                ),
              ]),
            );
          } else if (state is GetDocumentLoading) {
            return const MyLoader();
          } else {
            return MyErrorWidget(
              onPressed: () {
                var cubit = GetDocumentCubit.get(context);
                cubit.getDocument(doctype: 'salary_slip');
              },
            );
          }
        },
      ),
    );
  }
}
