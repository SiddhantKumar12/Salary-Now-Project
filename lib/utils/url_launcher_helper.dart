import 'package:url_launcher/url_launcher.dart';

class MyUrlLauncher {
  static String email = Uri.encodeComponent("hello@salarynow.in");
  static String subject = Uri.encodeComponent("");
  static String body = Uri.encodeComponent("");

  static Uri params = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=$subject &body=$body', //add subject and body here
  );

  static launchEmail() async {
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      throw 'Could not launch';
    }
  }
}
