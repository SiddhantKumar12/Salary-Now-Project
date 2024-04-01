import 'package:flutter/material.dart';
import 'package:salarynow/dashboard/network/modal/dashboard_modal.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../service_helper/api/api_strings.dart';
import '../../../service_helper/web_view_contoller.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_user_modal.dart';
import '../../../widgets/loader.dart';

class BankStatementWebView extends StatefulWidget {
  const BankStatementWebView({
    Key? key,
  }) : super(key: key);

  @override
  State<BankStatementWebView> createState() => _BankStatementWebViewState();
}

class _BankStatementWebViewState extends State<BankStatementWebView> {
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
        "${ApiStrings.baseUrl}${ApiStrings.bankStatementUrl}/${localUserModal!.responseData!.userId}/${dashBoardModal!.responseData!.loanDetails!.applicationNo!}";

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
      appBar: const InfoCustomAppBar(title: 'Net banking'),
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
