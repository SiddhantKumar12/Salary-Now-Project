import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/dotted_border_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../required_document/screens/req_document_view_screens/doc_Image_Screen.dart';
import '../utils/color.dart';

class DocViewImageWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  ///Doc Image Widget
  final String appBarTitle;
  final String tag;
  const DocViewImageWidget({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.boxFit,
    required this.title,
    required this.appBarTitle,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: tag,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DocImageScreen(typeTitle: title, appBarTitle: appBarTitle, imageUrl: imageUrl, tag: tag)),
              );
            },
            child: MyDottedBorder(
              widget: CachedNetworkImage(
                imageUrl: imageUrl,
                height: height ?? 250.h,
                width: width ?? double.maxFinite,
                fit: boxFit ?? BoxFit.cover,
                placeholder: (context, url) => MyLoader(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -2.h),
          child: Container(
            height: 55.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: MyColor.highLightBlueColor,
              border: Border.all(
                color: MyColor.turcoiseColor,
              ),
            ),
            child: Center(
              child: MyText(
                text: title,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
