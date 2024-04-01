import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/images.dart';

class MyLogoImageWidget extends StatelessWidget {
  const MyLogoImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      MyImages.logoImage,
      height: 200.h,
      width: 200.w,
    );
  }
}
