import 'package:flutter/material.dart';
import 'package:salarynow/utils/web_view.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../service_helper/web_view_contoller.dart';

class AboutUsWebView extends StatefulWidget {
  const AboutUsWebView({super.key});

  @override
  State<AboutUsWebView> createState() => _AboutUsWebViewState();
}

class _AboutUsWebViewState extends State<AboutUsWebView> {
  bool isLoading = true;

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewHelper.getWebView(
        url: MyWebViewUrl.aboutUs,
        onPageFinished: (url) {
          setState(() {
            isLoading = false;
          });
        });
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: MyWrittenText.aboutUsText),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: MyLoader(),
            ),
        ],
      ),
    );
  }
// #enddocregion webview_widget
}
