import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/text_widget.dart';

import '../../widgets/camera_button.dart';

class AadhaarCardPhotoScreen extends StatelessWidget {
  const AadhaarCardPhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoCustomAppBar(title: "Take Photo"),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                // MyCameraButton(),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.browse_gallery,
                              size: 50.h,
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: const MyText(
                            text: MyWrittenText.browseText,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
