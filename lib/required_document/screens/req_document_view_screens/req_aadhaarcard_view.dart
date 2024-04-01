import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/required_document/cubit/get_doc_cubit/get_document_cubit.dart';
import 'package:salarynow/widgets/docViewImageWidget.dart';
import 'package:salarynow/widgets/error.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';

class AadhaarViewScreen extends StatefulWidget {
  const AadhaarViewScreen({Key? key}) : super(key: key);

  @override
  State<AadhaarViewScreen> createState() => _AadhaarViewScreenState();
}

class _AadhaarViewScreenState extends State<AadhaarViewScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = GetDocumentCubit.get(context);
    cubit.getDocument(doctype: 'id_proof_file');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 2),
      body: BlocBuilder<GetDocumentCubit, GetDocumentState>(
        builder: (context, state) {
          if (state is GetDocumentLoading) {
            return const MyLoader();
          } else if (state is GetDocumentLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoTitleWidget(
                    title: MyWrittenText.aadhaarCardTitleText,
                    subtitle: MyWrittenText.viewDocument,
                    height: 100.h,
                  ),
                  SizedBox(height: 20.h),
                  DocViewImageWidget(
                    imageUrl: state.modal.data!.front!,
                    title: MyWrittenText.frontSide,
                    tag: 'aadhaar image 1',
                    appBarTitle: MyWrittenText.aadhaarCardTitleText,
                  ),
                  SizedBox(height: 20.h),
                  DocViewImageWidget(
                    imageUrl: state.modal.data!.back!,
                    title: MyWrittenText.backSide,
                    tag: 'aadhaar image 2',
                    appBarTitle: MyWrittenText.aadhaarCardTitleText,
                  ),
                ],
              ),
            );
          }
          return MyErrorWidget(onPressed: () {
            var cubit = GetDocumentCubit.get(context);
            cubit.getDocument(doctype: 'id_proof_file');
          });
        },
      ),
    );
  }
}
