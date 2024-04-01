import 'package:flutter/material.dart';
import 'package:salarynow/utils/color.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../service_helper/api/api_strings.dart';
import '../../../service_helper/web_view_contoller.dart';
import '../../../storage/local_storage.dart';
import '../../../storage/local_user_modal.dart';
import '../../../widgets/loader.dart';

class EMandateVideo extends StatefulWidget {
  const EMandateVideo({
    Key? key,
  }) : super(key: key);

  @override
  State<EMandateVideo> createState() => _EMandateVideoState();
}

class _EMandateVideoState extends State<EMandateVideo> {
  bool isLoading = true;
  late final WebViewController controller;
  LocalUserModal? localUserModal = MyStorage.getUserData();

  bool isAgreeSanction = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewHelper.getWebView(
        url: ApiStrings.mandateVideo,
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(),
      backgroundColor: MyColor.whiteColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 8,
                  child: Transform.scale(
                    scale: 1.15,
                    child: WebViewWidget(
                      controller: controller,
                    ),
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
