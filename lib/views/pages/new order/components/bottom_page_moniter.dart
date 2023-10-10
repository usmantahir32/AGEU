import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/dialogs/confirm_order.dart';
import 'package:Ageu/views/widgets/custom_snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dot_indicator.dart';

class BottomPageMoniter extends StatelessWidget {
  BottomPageMoniter({super.key});
  final cont = Get.find<AddOrderCont>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: SizeConfig.heightMultiplier * 6,
      width: SizeConfig.widthMultiplier * 90,
      decoration: BoxDecoration(
        color: ColorConstants.buttonColor,
        borderRadius: BorderRadius.circular(40),
      ),
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 4),
      child: Row(
        children: [
          InkWell(
            onTap: () => cont.currentSection.value > 0
                ? cont.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn)
                : null,
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.grey,
                ),
                SizedBox(width: SizeConfig.widthMultiplier * 2),
                Text(
                  tr('back').toUpperCase(),
                  style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w800, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Spacer(),
          DotIndicator(),
          const Spacer(),
          InkWell(
            onTap: () => _onNext(),
            child: Row(
              children: [
                Text(
                  tr('next').toUpperCase(),
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w800,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                SizedBox(width: SizeConfig.widthMultiplier * 2),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorConstants.primaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _openConfirmDialog() {
    cont.currentSection.value += 1;
    Get.dialog(ConfirmOrderDialog(), barrierDismissible: false);
  }

  _onNext() {
    if (cont.currentSection.value < 1) {
      //CEP SECTION
      if (cont.currentSection.value == 0) {
        if (cont.deliveryValidator()) {
          cont.altitudeValidationText.value = '';
          cont.complementValidateText.value = '';
          cont.pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        } 
      }
    } else {
      if (cont.items.value!.isNotEmpty) {
        _openConfirmDialog();
      } else {
        CustomSnackbar.showCustomSnackbar(true, 'Items cannot be empty');
      }
    }
  }
}
