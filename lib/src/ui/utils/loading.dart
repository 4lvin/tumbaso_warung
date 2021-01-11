
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tumbaso_warung/src/ui/utils/progress_dialog.dart';

class Dialogs {
  static ProgressDialog pr;
  static Future showLoading(
      BuildContext context,String message) async {

    pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
      message: message,
      borderRadius: 30.0,
      backgroundColor: Colors.black45,
      progressWidget: Lottie.asset(
        'assets/loadingcoffee.json',
        width: 200,
        height: 200,
        fit: BoxFit.fill,
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.bounceIn,
      // progress: 0.0,
      // maxProgress: 100.0,
    );
    return pr.show();
  }
  static Future dismiss(
      BuildContext context) async {

    pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    return pr.hide();
  }
}