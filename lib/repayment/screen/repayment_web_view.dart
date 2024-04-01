import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../dashboard/network/modal/dashboard_modal.dart';
import '../../service_helper/api/api_strings.dart';
import '../../service_helper/web_view_contoller.dart';
import '../../storage/local_storage.dart';
import '../../storage/local_user_modal.dart';
import '../../utils/color.dart';
import '../../widgets/information_widgets/info_appbar_widget.dart';
import '../../widgets/loader.dart';

class RepaymentWebView extends StatefulWidget {
  const RepaymentWebView({Key? key}) : super(key: key);

  @override
  State<RepaymentWebView> createState() => _RepaymentWebViewState();
}

class _RepaymentWebViewState extends State<RepaymentWebView> {
  bool isLoading = true;
  late final WebViewController controller;
  LocalUserModal? localUserModal = MyStorage.getUserData();
  DashBoardModal? dashBoardModal = MyStorage.getDashBoardData();

  bool isAgreeSanction = false;
  String url = "";

  @override
  void initState() {
    super.initState();
    url =
        "${ApiStrings.baseUrl}${ApiStrings.repaymentUrl}/${localUserModal!.responseData!.userId}/${dashBoardModal!.responseData!.loanDetails!.applicationNo!}";

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
      appBar: InfoCustomAppBar(title: MyWrittenText.repaymentText),
      backgroundColor: MyColor.whiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 8,
                  child: WebViewWidget(

                    controller: controller,
                  )),
            ],
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
