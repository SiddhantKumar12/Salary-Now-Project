import 'package:flutter/material.dart';
import 'package:salarynow/dashboard/network/modal/dashboard_modal.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../service_helper/api/api_strings.dart';
import '../../../service_helper/web_view_contoller.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_user_modal.dart';
import '../../../widgets/loader.dart';

class EMandateScreen extends StatefulWidget {
  final DashBoardModal dashBoardModal;
  const EMandateScreen({Key? key, required this.dashBoardModal}) : super(key: key);

  @override
  State<EMandateScreen> createState() => _EMandateScreenState();
}

class _EMandateScreenState extends State<EMandateScreen> {
  bool isLoading = true;
  late final WebViewController controller;
  LocalUserModal? localUserModal = MyStorage.getUserData();

  String url = '';

  @override
  void initState() {
    super.initState();
    url =
        "${ApiStrings.baseUrl}${ApiStrings.mandateShow}${localUserModal!.responseData!.userId}/${widget.dashBoardModal.responseData!.loanDetails!.applicationNo}";
    controller = WebViewHelper.getWebView(
        url: url,
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: 'Sign E-Mandate'),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (isLoading)
            const Center(
              child: MyLoader(),
            ),
        ],
      ),
    );
  }
}
