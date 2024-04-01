import 'package:flutter/material.dart';
import 'package:salarynow/Notification/screens/notification_screen.dart';
import 'package:salarynow/boarding/screen/on_boarding_screen.dart';
import 'package:salarynow/bottom_nav_bar/screen/bottom_nav.dart';
import 'package:salarynow/contact_us/screens/login_contact_us_screen.dart';
import 'package:salarynow/contact_us/screens/dashboard_contact_us.dart';
import 'package:salarynow/dashboard/network/modal/dashboard_modal.dart';
import 'package:salarynow/dashboard/screen/agreement_letter/agreement_letter_web_view.dart';
import 'package:salarynow/dashboard/screen/agreement_letter/loan_agreement_screen.dart';
import 'package:salarynow/dashboard/screen/mandate_video_webView/mandate_video_screen.dart';
import 'package:salarynow/dashboard/screen/not_interested_screen/not_interested_screen.dart';
import 'package:salarynow/dashboard/screen/sanction_letter/sanction_letter_webView.dart';
import 'package:salarynow/information/screens/banking_screen/banking_info_screen.dart';
import 'package:salarynow/information/screens/info_view_screens/banking_view_screen.dart';
import 'package:salarynow/information/screens/info_view_screens/personal_view_screens.dart';
import 'package:salarynow/information/screens/info_view_screens/professional_view_screens.dart';
import 'package:salarynow/information/screens/info_view_screens/residential_view_screens.dart';
import 'package:salarynow/information/screens/personal_screen/personal_info_screen.dart';
import 'package:salarynow/information/screens/residential_screen/govt_aadhaar_card_verify/govt_aadhar_card.dart';
import 'package:salarynow/information/screens/residential_screen/residential_info_screen.dart';
import 'package:salarynow/login/screen/login_screen.dart';
import 'package:salarynow/login/screen/otp_screen.dart';
import 'package:salarynow/packages/screen/loan_reject_screen.dart';
import 'package:salarynow/permission_handler/screens/permission_screen.dart';
import 'package:salarynow/profile/screen/profile_screen.dart';
import 'package:salarynow/registration/screen/registration_screen.dart';
import 'package:salarynow/required_document/screens/bank_statement/bank_statement.dart';
import 'package:salarynow/required_document/screens/req_aadhaarcard_screen.dart';
import 'package:salarynow/required_document/screens/req_address_proof.dart';
import 'package:salarynow/required_document/screens/req_document_screen.dart';
import 'package:salarynow/required_document/screens/req_document_view_screens/accomadation_view_screen.dart';
import 'package:salarynow/required_document/screens/req_document_view_screens/address_proof_view_screen.dart';
import 'package:salarynow/required_document/screens/req_document_view_screens/pan_card_view_screen.dart';
import 'package:salarynow/required_document/screens/req_document_view_screens/req_aadhaarcard_view.dart';
import 'package:salarynow/required_document/screens/req_pan_card_screen.dart';
import 'package:salarynow/required_document/screens/salary_slip.dart';
import 'package:salarynow/required_document/screens/salary_slip_month.dart';
import 'package:salarynow/routing/route_path.dart';
import 'package:salarynow/splash_screen/screen/splash_screen.dart';

import '../dashboard/screen/e-mandate_screen/e-mandate_screen.dart';
import '../information/screens/profession_screen/professional_info_screen.dart';
import '../permission_handler/screens/permission_web_view.dart';
import '../required_document/screens/accommodation_type_screen.dart';

class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// Splash Screen
      case RoutePath.splashScreenPage:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      /// OnBoarding Screen
      case RoutePath.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => OnBoardingScreen(),
        );

      /// Permission Screen

      case RoutePath.permissionScreen:
        final bool beforeRegistration = settings.arguments as bool;

        return MaterialPageRoute(
          builder: (_) => PermissionScreen(beforeRegistration: beforeRegistration),
        );

      /// PermissionWebScreen Screen

      case RoutePath.permissionScreenWebView:
        return MaterialPageRoute(
          builder: (_) => const PermissionWebView(),
        );

      /// LoginScreen Screen

      case RoutePath.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      /// Login Contact Us Screen

      case RoutePath.loginContactUsScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginContactUsScreen(),
        );

      /// OnBoarding Screen

      case RoutePath.otpScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final String mobileNumber = args['mobileNumber']!;
        final String imei = args['imei']!;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(
            mobileNumber: mobileNumber,
            imei: imei,
          ),
        );

      /// Registration Screen

      case RoutePath.registrationScreen:
        final String mobileNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => RegistrationScreen(mobileNumber: mobileNumber),
        );

      /// BotNavBar Screen

      case RoutePath.botNavBar:
        return MaterialPageRoute(
          builder: (_) => CustomBottomNavBar(),
        );

      /// DashBoardContact Us Screen

      case RoutePath.dashBoardContactUsScreen:
        return MaterialPageRoute(
          builder: (_) => const DashBoardContactUsScreen(),
        );

      /// Navigation Screen

      case RoutePath.navigation:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );

      /// loan Criteria  Screen

      case RoutePath.loanCriteria:
        return MaterialPageRoute(
          builder: (_) => const LoanCriteriaScreen(),
        );

      /// new navigation to implement

      /// DashBoard Screens

      case RoutePath.notInterestedScreen:
        final DashBoardModal dashBoardModal = settings.arguments as DashBoardModal;
        return MaterialPageRoute(
          builder: (_) => NotInterestedScreen(dashBoardModal: dashBoardModal),
        );

      case RoutePath.sanctionLetterWebViewScreen:
        final DashBoardModal dashBoardModal = settings.arguments as DashBoardModal;
        return MaterialPageRoute(
          builder: (_) => SanctionLetterWebView(dashBoardModal: dashBoardModal),
        );

      case RoutePath.loanAgreementScreen:
        final DashBoardModal dashBoardModal = settings.arguments as DashBoardModal;
        return MaterialPageRoute(
          builder: (_) => LoanAgreementScreen(dashBoardModal: dashBoardModal),
        );

      case RoutePath.agreementLetterWebScreen:
        final DashBoardModal dashBoardModal = settings.arguments as DashBoardModal;
        return MaterialPageRoute(
          builder: (_) => AgreementLetterWebView(dashBoardModal: dashBoardModal),
        );

      case RoutePath.eMandateScreen:
        final DashBoardModal dashBoardModal = settings.arguments as DashBoardModal;
        return MaterialPageRoute(
          builder: (_) => EMandateScreen(dashBoardModal: dashBoardModal),
        );

      case RoutePath.mandateVideoScreen:
        return MaterialPageRoute(
          builder: (_) => const EMandateVideo(),
        );

      /// Profile paths

      case RoutePath.personalScreen:
        return MaterialPageRoute(
          builder: (_) => const PersonalInformationScreen(),
        );
      case RoutePath.personalViewScreen:
        return MaterialPageRoute(
          builder: (_) => const PersonalViewScreen(),
        );
      case RoutePath.professionalScreen:
        return MaterialPageRoute(
          builder: (_) => ProfessionalInfoScreen(),
        );
      case RoutePath.professionalViewScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfessionalViewScreen(),
        );
      case RoutePath.govtAadhaarScreen:
        final args = settings.arguments as Map<String, dynamic>;

        final bool isDashBoardScreen = args['isDashBoardScreen'];
        final bool isApplyScreen = args['isApplyScreen'];
        return MaterialPageRoute(
          builder: (_) => GovtAadhaarCardVerify(isDashBoardScreen: isDashBoardScreen, isApplyScreen: isApplyScreen),
        );
      case RoutePath.residentialScreen:
        return MaterialPageRoute(
          builder: (_) => const ResidentialInfoScreen(),
        );
      case RoutePath.residentialViewScreen:
        return MaterialPageRoute(
          builder: (_) => const ResidentialViewScreen(),
        );
      case RoutePath.bankScreen:
        return MaterialPageRoute(
          builder: (_) => BankingInfoScreen(),
        );
      case RoutePath.bankViewScreen:
        return MaterialPageRoute(
          builder: (_) => const BankingViewScreen(),
        );
      case RoutePath.reqDocumentScreen:
        return MaterialPageRoute(
          builder: (_) => const ReqDocumentScreen(),
        );

      /// Req Doc Screen
      case RoutePath.aadhaarCardScreen:
        final Function refreshProfile = settings.arguments as Function;
        return MaterialPageRoute(
          builder: (_) => ReqAadhaarCardScreen(refreshProfile: refreshProfile),
        );
      case RoutePath.aadhaarViewScreen:
        return MaterialPageRoute(
          builder: (_) => const AadhaarViewScreen(),
        );
      case RoutePath.panCardScreen:
        final Function refreshProfile = settings.arguments as Function;

        return MaterialPageRoute(
          builder: (_) => ReqPanCardScreen(refreshProfile: refreshProfile),
        );
      case RoutePath.panCardViewScreen:
        return MaterialPageRoute(
          builder: (_) => const PanCardViewScreen(),
        );
      case RoutePath.addressProofScreen:
        final Function refreshProfile = settings.arguments as Function;

        return MaterialPageRoute(
          builder: (_) => ReqAddProofScreen(refreshProfile: refreshProfile),
        );
      case RoutePath.addressProofViewScreen:
        return MaterialPageRoute(
          builder: (_) => const AddressProofViewScreen(),
        );
      case RoutePath.accommodationScreen:
        final Function refreshProfile = settings.arguments as Function;

        return MaterialPageRoute(
          builder: (_) => AccommodationScreen(refreshProfile: refreshProfile),
        );
      case RoutePath.accommodationViewScreen:
        return MaterialPageRoute(
          builder: (_) => const AccomadationViewScreen(),
        );
      case RoutePath.salarySlipScreen:
        final Function refreshProfile = settings.arguments as Function;
        return MaterialPageRoute(
          builder: (_) => SalarySlipScreen(refreshProfile: refreshProfile),
        );
      case RoutePath.salarySlipMonthScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final String title = args['title']!;
        final Function refreshProfile = args['refreshProfile']!;
        return MaterialPageRoute(
          builder: (_) => SalarySlipMonthScreen(refreshSalary: refreshProfile, title: title),
        );
      case RoutePath.bankStatementScreen:
        final Function refreshProfile = settings.arguments as Function;
        return MaterialPageRoute(
          builder: (_) => BankStatement(refreshSalary: refreshProfile),
        );

      // case '/profile':
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => ProfileScreen(
      //         // argument1: args['argument1'],
      //         // argument2: args['argument2'],
      //         // argument3: args['argument3'],
      //         ),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  // static void navigateToHome(BuildContext context) {
  //   Navigator.pushNamed(context, '/home');
  // }
  //
  // static void navigateToOtpScreen(BuildContext context, String mobileNumber) {
  //   Navigator.pushNamed(context, '/otp_screen', arguments: mobileNumber);
  // }
  //
  // static void navigateToProfile({required BuildContext context, String? argument1, int? argument2, bool? argument3}) {
  //   Navigator.pushNamed(context, '/profile', arguments: {
  //     'argument1': argument1,
  //     'argument2': argument2,
  //     'argument3': argument3,
  //   });
  // }
}
