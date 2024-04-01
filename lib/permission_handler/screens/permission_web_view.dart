import 'package:flutter/material.dart';
import 'package:salarynow/utils/web_view.dart';
import 'package:salarynow/utils/written_text.dart';
import 'package:salarynow/widgets/information_widgets/info_appbar_widget.dart';
import 'package:salarynow/widgets/loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PermissionWebView extends StatefulWidget {
  const PermissionWebView({super.key});

  @override
  State<PermissionWebView> createState() => _PermissionWebViewState();
}

class _PermissionWebViewState extends State<PermissionWebView> {
  bool isLoading = true;

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(MyWebViewUrl.privatePolicyUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(MyWebViewUrl.privatePolicyUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InfoCustomAppBar(title: MyWrittenText.privatePolicyText),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading) const Center(child: MyLoader()),
        ],
      ),
    );
  }
}
