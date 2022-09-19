import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../utils/ui_utils.dart';

abstract class BaseStatefulState<T extends StatefulWidget> extends State<T> {
  BaseStatefulState();

  void showSnackBarFull(
    String title,
    String message,
  ) {
    UIUtils.showFullWidthSnackBar(title, message);
  }

  void showSnackBarFullError(
    String title,
    String message,
  ) {
    UIUtils.showFullWidthSnackBarError(title, message);
  }

  void showWarningDialog(
    String title,
    String desc,
    Function()? btnCancelOnPress,
    Function()? btnOkOnPress,
    Function(DismissType type)? onDismissCallback,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.cancel),
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      onDismissCallback: onDismissCallback,
      btnOkOnPress: btnOkOnPress,
    ).show();
  }

  void showErrorDialog(
    String title,
    String desc,
    Function()? btnOkOnPress,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      title: title,
      desc: desc,
      btnOkOnPress: btnOkOnPress,
      btnOkIcon: Icons.cancel,
      btnOkColor: Colors.red,
    ).show();
  }

  void showSuccessDialog(
    String title,
    String desc,
    Function(DismissType type)? onDismissCallback,
    Function()? btnOkOnPress,
  ) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      dialogType: DialogType.success,
      showCloseIcon: true,
      title: title,
      desc: desc,
      btnOkOnPress: btnOkOnPress,
      btnOkIcon: Icons.check_circle,
      onDismissCallback: onDismissCallback,
    ).show();
  }
}
