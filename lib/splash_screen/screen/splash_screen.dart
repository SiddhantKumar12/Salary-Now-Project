import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salarynow/splash_screen/cubit/splash_cubit.dart';
import '../../routing/route_path.dart';
import '../../utils/images.dart';
import 'maintenance_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) async {
          if (state is SplashLoadedState) {
            /// if response data is false that means there is maintenance going on
            if (state.appStatusModal.responseData == true) {
              /// checks the user is logged in or not
              if (state.isLoggedIn) {
                Navigator.pushReplacementNamed(context, RoutePath.botNavBar);
              } else {
                /// checks the user is seen the on Boarding Screen
                state.isUserOnBoard
                    ? Navigator.pushReplacementNamed(context, RoutePath.loginScreen)
                    : Navigator.pushReplacementNamed(context, RoutePath.onBoardingScreen);
              }
            } else {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const MaintenanceScreen(isError: false)));
            }
          }
          if (state is SplashErrorState) {
            /// App Status Error
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const MaintenanceScreen(isError: true)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Image.asset(
                  MyImages.logoGif,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
