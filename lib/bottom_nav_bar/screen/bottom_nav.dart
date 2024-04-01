import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salarynow/dashboard/screen/dashboard_screen.dart';
import 'package:salarynow/internet_connection/cubit/internet_cubit.dart';
import 'package:salarynow/internet_connection/no_internet_screen.dart';
import 'package:salarynow/packages/cubit/packages_cubit/packages_cubit.dart';
import 'package:salarynow/packages/screen/my_loan_screen.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/utils/color.dart';
import '../../dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import '../../form_helper/form_helper_cubit/form_helper_cubit.dart';
import '../../packages/screen/packages.dart';
import '../../profile/screen/profile_screen.dart';
import '../../repayment/cuibt/repayment/repayment_cubit.dart';
import '../../repayment/screen/repayment_screen.dart';
import '../../utils/icons.dart';
import '../cubit/navbar_cubit.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  final screens = const [
    DashBoardScreen(),
    PackagesScreen(),
    MyLoanScreen(),
    RepaymentScreen(),
    ProfileScreen(),
  ];

  final bottomItemList = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Packages'),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Apply'),
    BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Repayment'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  static final List<String> _svgPaths = [
    MyIcons.homeIcon,
    MyIcons.packagesIcon,
    MyIcons.applyIcon,
    MyIcons.repaymentIcon,
    MyIcons.profileIcon,
  ];

  static final List<String> _tabNames = [
    'Home',
    'Products',
    'Apply',
    'Repayment',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
        var cubit = NavbarCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: IndexedStack(
              index: cubit.currentIndex,
              children: screens,
            ),
            bottomNavigationBar: BlocListener<InternetCubit, InternetState>(
              listener: (context, state) {
                if (state == InternetState.connected) {
                  // MySnackBar.showInternetSnackbar(context);
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NoInternetScreen()));
                  // MySnackBar.showNotInternetSnackbar(context);
                }
              },
              child: BottomNavigationBar(
                items: List.generate(
                  _svgPaths.length,
                  (index) => BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      _svgPaths[index],
                      width: 28.w,
                      height: 28.h,
                      color: cubit.currentIndex == index ? MyColor.turcoiseColor : Colors.grey,
                    ),
                    label: _tabNames[index],
                  ),
                ),
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                selectedItemColor: MyColor.turcoiseColor,
                unselectedItemColor: MyColor.subtitleTextColor,
                onTap: (int value) {
                  cubit.changeBottomNavBar(value);

                  if (cubit.currentIndex == 0) {
                    var dashBoardCubit = DashboardCubit.get(context);
                    dashBoardCubit.getDashBoardData();
                  } else if (cubit.currentIndex == 1) {
                    var packagesCubit = PackagesCubit.get(context);
                    packagesCubit.getPackages();
                  } else if (cubit.currentIndex == 3) {
                    var repayCubit = RepaymentCubit.get(context);
                    repayCubit.getRepayment();
                  } else if (cubit.currentIndex == 4) {
                    var profileCubit = ProfileCubit.get(context);
                    profileCubit.getProfile();
                    var formHelperCubit = FormHelperApiCubit.get(context);
                    formHelperCubit.getUserCommonList();
                    formHelperCubit.getState();
                    formHelperCubit.getSalaryModeList();
                    formHelperCubit.getEmploymentType();
                  }
                },
                elevation: 15,
                selectedIconTheme: IconThemeData(size: 34.h),
                unselectedIconTheme: IconThemeData(size: 30.h),
                unselectedFontSize: 12.sp,
                selectedFontSize: 14.sp,
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),
            ),
          ),
        );
      },
    );
  }
}
