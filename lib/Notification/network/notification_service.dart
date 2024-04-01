import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salarynow/storage/local_storage.dart';
import 'package:salarynow/storage/local_storage_strings.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log("message received! ${message.notification!.title}");
}

class NotificationService {
  static Future<void> initialize() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

    try {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          MyStorage.writeData(MyStorageString.fcmToken, token);
          log(token);
        }

        FirebaseMessaging.onBackgroundMessage(backgroundHandler);
        log("Notifications Initialized!");
      }
    } on FirebaseException catch (e) {
      log(e.message.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
