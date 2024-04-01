import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/written_text.dart';
import '../../../widgets/docViewImageWidget.dart';
import '../../../widgets/error.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/information_widgets/info_title_widget.dart';
import '../../../widgets/loader.dart';
import '../../cubit/get_doc_cubit/get_document_cubit.dart';

class PanCardViewScreen extends StatefulWidget {
  const PanCardViewScreen({Key? key}) : super(key: key);

  @override
  State<PanCardViewScreen> createState() => _PanCardViewScreenState();
}

class _PanCardViewScreenState extends State<PanCardViewScreen> {
  @override
  void initState() {
    super.initState();
    var cubit = GetDocumentCubit.get(context);
    cubit.getDocument(doctype: 'pan_card');
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
                    title: MyWrittenText.panCardTitleText,
                    subtitle: MyWrittenText.viewDocument,
                    height: 100.h,
                  ),
                  SizedBox(height: 20.h),
                  DocViewImageWidget(
                    appBarTitle: MyWrittenText.panCardTitleText,
                    tag: 'Pan Card',
                    imageUrl: state.modal.data!.front!,
                    title: 'Front Side',
                  ),
                  // SizedBox(height: 20.h),
                  // DocViewImageWidget(imageUrl: state.modal.data!.back!, title: 'Back Side'),
                ],
              ),
            );
          }
          return MyErrorWidget(onPressed: () {
            var cubit = GetDocumentCubit.get(context);
            cubit.getDocument(doctype: 'pan_card');
          });
        },
      ),
    );
  }
}
