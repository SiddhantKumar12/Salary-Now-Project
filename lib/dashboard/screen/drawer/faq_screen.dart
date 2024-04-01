import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/dashboard/cubit/faq_cubit/faq_cubit.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/dialog_box_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/information_widgets/info_title_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import '../../../required_document/network/modal/selfie_modal.dart';
import '../../../storage/local_storage.dart';
import '../../../utils/color.dart';
import '../../../utils/on_screen_loader.dart';
import '../../../utils/snackbar.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../cubit/faq_cubit/faq_post/faq_post_cubit.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({Key? key}) : super(key: key);

  final SelfieModal? selfieModal = MyStorage.getSelfieData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(
        title: MyWrittenText.faqText,
      ),
      body: BlocProvider(
        create: (context) => FaqCubit(),
        child: BlocConsumer<FaqCubit, FaqState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FaqLoaded) {
              List<AccordionSection> newList = [];

              for (int i = 0; i < int.parse(state.faqModal.responseData!.length.toString()); i++) {
                newList.add(AccordionSection(
                    isOpen: false,
                    header: MyText(text: state.faqModal.responseData![i].question!),
                    content: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: Column(
                        children: [
                          MyText(
                            text: state.faqModal.responseData![i].answer!, textAlign: TextAlign.center,
                            // textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 20.sp),
                          Column(
                            children: [
                              MyButton(
                                  text: 'Yes',
                                  onPressed: () {
                                    FaqPostCubit.get(context).postFaq(
                                      type: 'Yes',
                                      question: state.faqModal.responseData![i].question!,
                                    );
                                  }),
                              SizedBox(height: 10.sp),
                              MyButton(
                                  buttonColor: MyColor.whiteColor,
                                  borderSide: const BorderSide(color: MyColor.turcoiseColor, width: 2),
                                  text: 'No',
                                  textColor: MyColor.blackColor,
                                  onPressed: () {
                                    FaqPostCubit.get(context).postFaq(
                                      type: 'Yes',
                                      question: state.faqModal.responseData![i].question!,
                                    );
                                  })
                            ],
                          ),
                        ],
                      ),
                    )));
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    const InfoTitleWidget(
                      title: 'How Can We Help you ?',
                      subtitle: '',
                    ),
                    BlocListener<FaqPostCubit, FaqPostState>(
                      listener: (context, state) {
                        if (state is FaqPostLoading) {
                          MyScreenLoader.onScreenLoader(context);
                        }
                        if (state is FaqPostLoaded) {
                          Navigator.pop(context);
                          MyDialogBox.faqDialogBox(
                            context: context,
                            title: selfieModal?.data?.fullname ?? '',
                          );
                        }
                        if (state is FaqPostError) {
                          Navigator.pop(context);
                          MySnackBar.showSnackBar(context, state.error);
                        }
                      },
                      child: Accordion(
                        rightIcon: const SizedBox(),
                        maxOpenSections: 1,
                        headerBackgroundColorOpened: MyColor.turcoiseColor.withOpacity(0.5),
                        headerBackgroundColor: MyColor.subtitleTextColor.withOpacity(0.2),
                        scaleWhenAnimating: true,
                        openAndCloseAnimation: true,
                        disableScrolling: true,
                        headerPadding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                        children: newList,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is FaqLoading) {
              return const MyLoader();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
