import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bottom_nav_bar/cubit/navbar_cubit.dart';
import '../../utils/images.dart';
import '../../utils/written_text.dart';
import '../../widgets/dashboard_widget/dashboard_list_tile.dart';

class DashBoardInitialWidget extends StatelessWidget {
  const DashBoardInitialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashBoardListTileOne(
          onPressed: () {
            var cubit = NavbarCubit.get(context);
            cubit.changeBottomNavBar(2);
          },
          title: MyWrittenText.newLoanText,
          image: MyImages.newLoanImage,
          textButtonTitle: MyWrittenText.applyText,
        ),
        DashBoardListTileOne(
          onPressed: () {
            var cubit = NavbarCubit.get(context);
            cubit.changeBottomNavBar(1);
          },
          title: MyWrittenText.calculatorText,
          image: MyImages.calculatorImage,
          textButtonTitle: MyWrittenText.viewText,
        ),
        DashBoardListTileOne(
          onPressed: () {
            var cubit = NavbarCubit.get(context);
            cubit.changeBottomNavBar(4);
          },
          title: MyWrittenText.profileText,
          image: MyImages.profileImage,
          textButtonTitle: MyWrittenText.viewText,
        ),
        SizedBox(height: 15.h),
      ],
    );
  }
}
