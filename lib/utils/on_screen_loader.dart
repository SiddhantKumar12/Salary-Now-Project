import 'package:flutter/material.dart';

class MyScreenLoader {
  static onScreenLoader(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

// onWillPop: () async {
// // Return false to prevent the dialog from being dismissed
// return false;
// },
