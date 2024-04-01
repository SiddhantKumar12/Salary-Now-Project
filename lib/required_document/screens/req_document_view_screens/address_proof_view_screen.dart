import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/written_text.dart';
import '../../../widgets/docViewImageWidget.dart';
import '../../../widgets/error.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/text_widget.dart';
import '../../cubit/get_doc_cubit/get_document_cubit.dart';

class AddressProofViewScreen extends StatefulWidget {
  const AddressProofViewScreen({Key? key}) : super(key: key);

  @override
  State<AddressProofViewScreen> createState() => _AddressProofViewScreenState();
}

class _AddressProofViewScreenState extends State<AddressProofViewScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = GetDocumentCubit.get(context);
    cubit.getDocument(doctype: 'address_proof');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(navigatePopNumber: 2),
      body: BlocBuilder<GetDocumentCubit, GetDocumentState>(
        builder: (context, state) {
          if (state is GetDocumentLoading) {
            return const MyLoader();
          } else if (state is AddressProofLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoTitleWidget(
                    title: MyWrittenText.addressProofTitleText,
                    subtitle: MyWrittenText.viewDocument,
                    height: 100.h,
                  ),
                  SizedBox(height: 15.h),
                  Align(
                      alignment: Alignment.center,
                      child: MyText(
                        text: state.modal.data?.docType?.name ?? '',
                        fontSize: 20.sp,
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(height: 10.h),
                  state.modal.data!.front!.isNotEmpty
                      ? DocViewImageWidget(
                          appBarTitle: MyWrittenText.addressProofTitleText,
                          imageUrl: state.modal.data!.front!,
                          tag: 'address proof 1',
                          title: 'Front Side',
                        )
                      : const SizedBox(),
                  SizedBox(height: 20.h),
                  state.modal.data!.back!.isNotEmpty
                      ? DocViewImageWidget(
                          appBarTitle: MyWrittenText.addressProofTitleText,
                          tag: 'address proof 2',
                          imageUrl: state.modal.data!.back!,
                          title: 'Back Side',
                        )
                      : const SizedBox(),
                ],
              ),
            );
          }
          return MyErrorWidget(onPressed: () {
            var cubit = GetDocumentCubit.get(context);
            cubit.getDocument(doctype: 'address_proof');
          });
        },
      ),
    );
  }
}
