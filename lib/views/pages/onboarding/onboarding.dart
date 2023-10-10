import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/icons.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/onboarding/components/lang_button.dart';
import 'package:Ageu/views/widgets/custom_button.dart';
import 'package:Ageu/views/widgets/show_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({super.key});
  final authCont = Get.put(AuthCont());
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => ShowLoading(
        inAsyncCall: authCont.isLoading.value,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.heightMultiplier*7),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:  EdgeInsets.only(right: SizeConfig.widthMultiplier*5),
                    child: SelectLangButton(),
                  )),
                SizedBox(height: SizeConfig.heightMultiplier*5),

                //ONBOARIDNG IMAGE
                Hero(
                  tag: 'splash',
                  child: Image.asset(IconConstants.appIcon,
                      height: SizeConfig.heightMultiplier * 40),
                ),
                //TITLE
                Text('Welcome to Hoggai!', style: textTheme.headlineSmall)
                    .tr(),
                SizedBox(height: SizeConfig.heightMultiplier * 1),
                //SUBTITLE
                Text('Your budget app made easy',
                        style: textTheme.bodySmall!
                            .copyWith(color: Colors.grey.shade400))
                    .tr(),
                SizedBox(height: SizeConfig.heightMultiplier * 8),
                //BUTTON
                CustomButton(
                    text: 'to enter', onTap: () => authCont.authorization()),
                //REGISTER ACCOUNT
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: textTheme.bodySmall,
                    ).tr(),
                    TextButton(
                        onPressed: () => authCont.authorization(),
                        child: Text(
                          'Create one now',
                          style: textTheme.bodySmall!.copyWith(
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.w600),
                        ).tr()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
