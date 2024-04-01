import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../service_helper/web_view_contoller.dart';
import '../../../widgets/information_widgets/info_appbar_widget.dart';
import '../../../widgets/loader.dart';

class PreLoanWebView extends StatefulWidget {
  final String appBarTitle;
  final String url;
  const PreLoanWebView({Key? key, required this.appBarTitle, required this.url}) : super(key: key);

  @override
  State<PreLoanWebView> createState() => _PreLoanWebViewState();
}

class _PreLoanWebViewState extends State<PreLoanWebView> {
  bool isLoading = true;
  late final WebViewController controller;

  String url = '';

  @override
  void initState() {
    super.initState();
    url = ('https://docs.google.com/gview?embedded=true&url=${widget.url}');
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
      appBar: InfoCustomAppBar(title: widget.appBarTitle),
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
