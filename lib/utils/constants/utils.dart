import 'package:flutter/material.dart';

class TDeviceUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
  static double getAppBarHeight(){
  return kToolbarHeight;
}

}



