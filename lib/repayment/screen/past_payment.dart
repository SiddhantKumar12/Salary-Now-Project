import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';

import '../../utils/color.dart';
import '../../utils/written_text.dart';
import '../../widgets/dashboard_widget/dashboard_expansion_tile_widget.dart';
import '../../widgets/information_widgets/info_title_widget.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InfoCustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: const InfoTitleWidget(
              title: MyWrittenText.payTitleText,
              subtitle: MyWrittenText.paySubText,
            ),
          ),
          DashBoardExpansionTIle(
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: MyColor.greenColor,
                  radius: 15.r,
                  child: Icon(
                    Icons.done,
                    size: 20.h,
                    color: MyColor.whiteColor,
                  ),
                ),
              ],
            ),
            subtitle: DateTime.now().toString().substring(0, 10),
            title: "${MyWrittenText.rupeeSymbol} 2387",
            children: const <Widget>[
              ListTile(
                title: Text(
                  "description",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
