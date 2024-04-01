import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkClass {
  Future<String> createLink(String path) async {
    final String url = "https://salarynow.in?$path";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: "https://salarynow.page.link",
      androidParameters: const AndroidParameters(packageName: "com.app.salarynow", minimumVersion: 0),
      // iosParameters: const IOSParameters(bundleId: "com.example.app.ios"),
    );
    final FirebaseDynamicLinks dynamicLink = FirebaseDynamicLinks.instance;
    final refLink = await dynamicLink.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;
      // Fluttertoast.showToast(msg: refLink.toString());
    } else {
      print("No Link Found");
    }
  }
}

// DynamicLinkClass().initDynamicLink();
