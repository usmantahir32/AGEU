import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/data.dart';
import 'package:Ageu/constants/icons.dart';
import 'package:Ageu/constants/local_db.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguageBS extends GetWidget<AuthCont> {
  SelectLanguageBS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 26,
      width: SizeConfig.widthMultiplier * 100,
      decoration: BoxDecoration(
          color: ColorConstants.buttonColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 5,
          vertical: SizeConfig.heightMultiplier * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select language',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),
          ListView.builder(
              itemCount: languages.length,
              shrinkWrap: true,
              itemBuilder: (_, i) => Obx(
                    () => ListTile(
                      onTap: () => _onListTap(context, i),
                      trailing: controller.userLanguage.value == languages[i]
                          ? Icon(Icons.done, color: Colors.white)
                          : null,
                      leading: Image.asset(
                        i == 0
                            ? IconConstants.flagUK
                            : IconConstants.flagBrazil,
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      title: Text(
                        languages[i],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  _onListTap(BuildContext context, int index) async {
    final prefs = await SharedPreferences.getInstance();
    if (index == 0) {
      Get.updateLocale(const Locale("en"));
      context.locale = const Locale("en", "US");
      controller.userLanguage.value = 'English';
      prefs.setString(LocalDBconstants.appLanguage, languages[0]);
    }
    if (index == 1) {
      Get.updateLocale(const Locale("pt"));
      context.locale = const Locale("pt", "BR");
      controller.userLanguage.value = 'Portugese';
      prefs.setString(LocalDBconstants.appLanguage, languages[1]);
    }
    Get.back();
  }
}
