import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';
import '../../../widgets/dotted_border_widget.dart';
import '../../../widgets/loader.dart';

class DocImageScreen extends StatelessWidget {
  final String appBarTitle;
  final String imageUrl;
  final String tag;
  final String typeTitle;
  const DocImageScreen(
      {Key? key, required this.appBarTitle, required this.imageUrl, required this.tag, required this.typeTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoCustomAppBar(title: appBarTitle, navigatePopNumber: 3, popScreen: true),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(text: typeTitle, fontSize: 20.sp),
              SizedBox(height: 20.h),
              Hero(
                tag: tag,
                child: MyDottedBorder(
                  widget: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 500.h,
                    width: 400.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const MyLoader(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
