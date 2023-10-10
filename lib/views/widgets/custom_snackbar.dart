import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';


class CustomSnackbar {
  static showCustomSnackbar(bool isError,String text) {
    return AnimatedSnackBar.material(
      tr(text),
      
      type:isError? AnimatedSnackBarType.error:AnimatedSnackBarType.success
    ).show(Get.overlayContext!);
  }
}
