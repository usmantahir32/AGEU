import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/icons.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'select_language.dart';

class SelectLangButton extends GetWidget<AuthCont> {
  const SelectLangButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => Get.bottomSheet(SelectLanguageBS()),
      child: Container(
        height: SizeConfig.heightMultiplier * 3.5,
        width: SizeConfig.widthMultiplier * 35,
        margin: EdgeInsets.only(
            bottom: SizeConfig.heightMultiplier * 1.4,
            top: SizeConfig.heightMultiplier * 1.4,
            left: SizeConfig.widthMultiplier * 5),
        decoration: BoxDecoration(
            color: ColorConstants.buttonColor,
            borderRadius: BorderRadius.circular(60)),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 2,
                width: SizeConfig.widthMultiplier * 6,
                child: Image.asset(
                  controller.userLanguage.value == 'English'
                      ? IconConstants.flagUK
                      : IconConstants.flagBrazil,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 2),
              Text(controller.userLanguage.value,
                  style: textTheme.labelSmall!.copyWith(color: Colors.white)),
              const Icon(Icons.arrow_drop_down_rounded, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
