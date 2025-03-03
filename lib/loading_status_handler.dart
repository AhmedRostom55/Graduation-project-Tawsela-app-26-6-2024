import 'dart:io';

import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';

class LoadingStatusHandler {
  // Initialize SVProgressHUD style throughout the app
  static void initialize() {
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom);
    SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black);
    if (Platform.isIOS) {
      SVProgressHUD.setMinimumDismissTimeInterval(1.5);
    } else {
      SVProgressHUD.setMinimumDismissTimeInterval(4);
    }
    SVProgressHUD.setMaximumDismissTimeInterval(4);
    SVProgressHUD.setHapticsEnabled(true);
    SVProgressHUD.setRingThickness(4);
  }

  static void startLoading() {
    SVProgressHUD.show();
  }

  static void startLoadingWithText(String text) {
    SVProgressHUD.show(status: text);
  }

  static void startLoadingWithProgress(num progress) {
    SVProgressHUD.showProgress(progress);
  }

  static void startLoadingWithProgressAndText(num progress, String text) {
    SVProgressHUD.showProgress(progress, status: text);
  }

  static void completeLoading() {
    // dismiss loading immediately without text
    SVProgressHUD.dismiss();
  }

  static Future<void> completeLoadingWithText(String text) {
    // text to show when loading is completed
    SVProgressHUD.showSuccess(status: text);
    // Add delay to match the duration of the success HUD
    if (Platform.isIOS) {
      return Future.delayed(const Duration(milliseconds: 1500));
    } else {
      return Future.delayed(const Duration(milliseconds: 4000));
    }
  }

  static void errorLoading([String? error]) {
    if (error != null) {
      SVProgressHUD.showError(status: "حدث خطأ، الرجاء المحاولة مرة اخرى\n$error");
    } else {
      SVProgressHUD.showError(status: "حدث خطأ، الرجاء المحاولة مرة اخرى");
    }
  }
}