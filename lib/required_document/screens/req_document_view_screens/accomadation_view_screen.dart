import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../../../utils/written_text.dart';
import '../../../widgets/docViewImageWidget.dart';
import '../../../widgets/error.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../cubit/get_doc_cubit/get_document_cubit.dart';

class AccomadationViewScreen extends StatefulWidget {
  const AccomadationViewScreen({Key? key}) : super(key: key);

  @override
  State<AccomadationViewScreen> createState() => _AccomadationViewScreenState();
}

class _AccomadationViewScreenState extends State<AccomadationViewScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = GetDocumentCubit.get(context);
    cubit.getDocument(doctype: 'rent_agreement_file');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 2),
      body: BlocBuilder<GetDocumentCubit, GetDocumentState>(
        builder: (context, state) {
          if (state is GetDocumentLoading) {
            return const MyLoader();
          } else if (state is AccommodationReqLoaded) {
            var data = state.modal.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoTitleWidget(
                    title: MyWrittenText.accommodationType,
                    subtitle: MyWrittenText.viewDocument,
                    height: 100.h,
                  ),
                  SizedBox(height: 15.h),
                  Align(
                      alignment: Alignment.center,
                      child: MyText(
                        fontSize: 20.sp,
                        text: data?.residencialStatus ?? '',
                      )),
                  SizedBox(height: 15.h),
                  data?.residencialStatus?.toUpperCase() == 'OWN'
                      ? SizedBox()
                      : DocViewImageWidget(
                          tag: 'Accomodation',
                          appBarTitle: MyWrittenText.accommodationType,
                          imageUrl: state.modal.data?.front ?? '',
                          title: 'Front Side',
                        ),
                ],
              ),
            );
          }
          return MyErrorWidget(onPressed: () {
            var cubit = GetDocumentCubit.get(context);
            cubit.getDocument(doctype: 'rent_agreement_file');
          });
        },
      ),
    );
  }
}
