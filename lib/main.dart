import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salarynow/boarding/cubit/save_common_id/save_common_id_cubit.dart';
import 'package:salarynow/bottom_nav_bar/cubit/navbar_cubit.dart';
import 'package:salarynow/dashboard/cubit/app_version_cubit/app_version_cubit.dart';
import 'package:salarynow/dashboard/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:salarynow/dashboard/cubit/delete_callback/delete_callback_cubit.dart';
import 'package:salarynow/dashboard/cubit/faq_cubit/faq_post/faq_post_cubit.dart';
import 'package:salarynow/dashboard/cubit/get_selfie_cubit/get_selfie_cubit.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/micro_user_disclaimer/micro_user_disclaimer_cubit.dart';
import 'package:salarynow/dashboard/cubit/micro_user_cubit/update_micro_status/update_micro_status_cubit.dart';
import 'package:salarynow/information/cubit/employment_cubit/loan_emp_cubit.dart';
import 'package:salarynow/information/cubit/residential_cubit/aadhaar_card_verification/aadhaar_card_verification_cubit.dart';
import 'package:salarynow/Notification/network/notification_service.dart';
import 'package:salarynow/packages/cubit/packages_cubit/packages_cubit.dart';
import 'package:salarynow/packages/cubit/slider_cubit.dart';
import 'package:salarynow/permission_handler/cubit/call_log_cubit/call_logs_cubit.dart';
import 'package:salarynow/profile/cubit/cancel_mandate/cancel_mandate_cubit.dart';
import 'package:salarynow/reference_number/cubit/contact_ref_status/contact_ref_status_cubit.dart';
import 'package:salarynow/permission_handler/cubit/imei_cubit/imei_cubit.dart';
import 'package:salarynow/permission_handler/cubit/location_cubit/location_tracker_cubit.dart';
import 'package:salarynow/permission_handler/cubit/sms_cubit/sms_cubit.dart';
import 'package:salarynow/form_helper/doc_cubit/document_cubit.dart';
import 'package:salarynow/form_helper/form_helper_cubit/bank_list_cubit.dart';
import 'package:salarynow/form_helper/form_helper_cubit/form_helper_cubit.dart';
import 'package:salarynow/form_helper/form_helper_cubit/salary_cubit.dart';
import 'package:salarynow/information/cubit/update_info_cubit/update_info_cubit.dart';
import 'package:salarynow/internet_connection/cubit/internet_cubit.dart';
import 'package:salarynow/login/cubit/login_cubit.dart';
import 'package:salarynow/packages/cubit/apply_loan_cubit/apply_loan_cubit.dart';
import 'package:salarynow/packages/cubit/loan_amount_cubit/loan_amount_cubit.dart';
import 'package:salarynow/packages/cubit/loan_slider_cubit/loan_slider_cubit.dart';
import 'package:salarynow/permission_handler/cubit/all_permission_cubit/permission_cubit.dart';
import 'package:salarynow/profile/cubit/profile_cubit.dart';
import 'package:salarynow/reference_number/cubit/contact_ref/contact_ref_cubit.dart';
import 'package:salarynow/reference_number/cubit/user_ref_number/user_reference_number_cubit.dart';
import 'package:salarynow/registration/cubit/pan_card_validation/pan_card_validation_cubit.dart';
import 'package:salarynow/registration/cubit/registration_cubit.dart';
import 'package:salarynow/repayment/cuibt/repayment/repayment_cubit.dart';
import 'package:salarynow/required_document/cubit/bank_statement_date/bank_statement_get_modal_cubit.dart';
import 'package:salarynow/required_document/cubit/file_picker_cubit/file_picker_cubit.dart';
import 'package:salarynow/required_document/cubit/get_doc_cubit/get_document_cubit.dart';
import 'package:salarynow/required_document/cubit/req_doc_cubit/req_document_cubit.dart';
import 'package:salarynow/required_document/cubit/selfie_cubit/selfie_cubit.dart';
import 'package:salarynow/routing/route_generator.dart';
import 'package:salarynow/routing/route_path.dart';
import 'package:salarynow/security/cubit/security_cubit.dart';
import 'package:salarynow/splash_screen/cubit/splash_cubit.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/utils/theme_data.dart';
import 'package:salarynow/utils/written_text.dart';
import 'Notification/cubit/post_fcm_token_cubit.dart';
import 'dashboard/cubit/carousel_slider_cubit/carousel_slider_cubit.dart';
import 'dashboard/cubit/loan_otp_agreement/loan_otp_agreement_cubit.dart';
import 'dashboard/cubit/loan_verify_otp_agreement/loan_verify_otp_agree_cubit.dart';
import 'dashboard/cubit/micro_user_cubit/check_micro_user/check_micro_user_cubit.dart';
import 'dashboard/cubit/micro_user_cubit/micro_user_post_disclaimer/micro_user_post_disclaimer_cubit.dart';
import 'dashboard/cubit/post_not_interested/post_not_intrested_cubit.dart';
import 'dashboard/cubit/req_callback/req_callback_cubit.dart';
import 'dashboard/cubit/sanction_cubit/get_sanction_cubit.dart';
import 'firebase_options.dart';
import 'form_helper/form_helper_cubit/search_cubit.dart';
import 'information/cubit/banking_cubit/banking_detail_cubit.dart';
import 'information/cubit/residential_cubit/aadhaar_card_otp/aadhaar_card_otp_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: MyColor.turcoiseColor));

  await GetStorage.init();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'salarynow',
      options: DefaultFirebaseOptions.currentPlatform,
    ).whenComplete(() {
      print("completedAppInitialize");
    });
  }
  await NotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SplashCubit()),
            BlocProvider(create: (context) => PermissionCubit()),
            BlocProvider(create: (context) => InternetCubit()),
            BlocProvider(create: (context) => LoginCubit()),
            BlocProvider(create: (context) => RegistrationCubit()),
            BlocProvider(create: (context) => NavbarCubit()),
            BlocProvider(create: (context) => ProfileCubit()),
            BlocProvider(create: (context) => FormHelperApiCubit()),
            BlocProvider(create: (context) => SearchCubit()),
            BlocProvider(create: (context) => BankListCubit()),
            BlocProvider(create: (context) => BankingDetailCubit()),
            BlocProvider(create: (context) => ReqDocumentCubit()),
            BlocProvider(create: (context) => DocumentCubit()),
            BlocProvider(create: (context) => FilePickerCubit()),
            BlocProvider(create: (context) => GetDocumentCubit()),
            BlocProvider(create: (context) => SelfieCubit()),
            BlocProvider(create: (context) => GetDocumentCubit()),
            BlocProvider(create: (context) => LoanCalculatorCubit()),
            BlocProvider(create: (context) => LoanSliderCubit()),
            BlocProvider(create: (context) => ApplyLoanCubit()),
            BlocProvider(create: (context) => ApplyLoanCubit()),
            BlocProvider(create: (context) => RepaymentCubit()),
            BlocProvider(create: (context) => DashboardCubit()),
            BlocProvider(create: (context) => PackagesCubit()),
            BlocProvider(create: (context) => SalaryCubit()),
            BlocProvider(create: (context) => LoanEmpCubit()),
            BlocProvider(create: (context) => UpdateInfoCubit()),
            BlocProvider(create: (context) => CallLogsCubit()),
            BlocProvider(create: (context) => SmsCubit()),
            BlocProvider(create: (context) => LocationTrackerCubit()),
            BlocProvider(create: (context) => ImeiCubit()),
            BlocProvider(create: (context) => ReqCallbackCubit()),
            BlocProvider(create: (context) => DeleteCallbackCubit()),
            BlocProvider(create: (context) => SliderCubit()),
            BlocProvider(create: (context) => ContactRefCubit()),
            BlocProvider(create: (context) => ContactRefStatusCubit()),
            BlocProvider(create: (context) => GetSelfieCubit()),
            BlocProvider(create: (context) => UserReferenceNumberCubit()),
            BlocProvider(create: (context) => SanctionCubit()),
            BlocProvider(create: (context) => LoanAgreementOTPCubit()),
            BlocProvider(create: (context) => LoanVerifyOtpAgreeCubit()),
            BlocProvider(create: (context) => PostNotInterestedCubit()),
            BlocProvider(create: (context) => CarouselSliderCubit()),
            BlocProvider(create: (context) => SecurityCubit()),
            BlocProvider(create: (context) => CheckMicroUserCubit()),
            BlocProvider(create: (context) => UpdateMicroStatusCubit()),
            BlocProvider(create: (context) => MicroUserDisclaimerCubit()),
            BlocProvider(create: (context) => MicroUserPostDisclaimerCubit()),
            BlocProvider(create: (context) => MicroUserPostDisclaimerCubit()),
            BlocProvider(create: (context) => PostFcmTokenCubit()),
            BlocProvider(create: (context) => FaqPostCubit()),
            BlocProvider(create: (context) => SaveCommonIdCubit()),
            BlocProvider(create: (context) => PanCardValidationCubit()),
            BlocProvider(create: (context) => AadhaarCardOtpCubit()),
            BlocProvider(create: (context) => AadhaarCardVerificationCubit()),
            BlocProvider(create: (context) => AppVersionCubit()),
            BlocProvider(create: (context) => BankStatementGetCubit()),
            BlocProvider(create: (context) => CancelMandateCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: MyWrittenText.appName,
            theme: MyAppThemeData.themeData,
            // home: GovtAadhaarCardVerify(),
            initialRoute: RoutePath.splashScreenPage,
            onGenerateRoute: MyRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
