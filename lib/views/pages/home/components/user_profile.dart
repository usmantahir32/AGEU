import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/onboarding/components/lang_button.dart';
import 'package:Ageu/views/widgets/confirmation_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  UserProfile({
    super.key,
  });
  final authCont = Get.find<AuthCont>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.bounceInOut,
        height: !authCont.isUserProfile.value
            ? 0
            : SizeConfig.heightMultiplier * 20,
        width:
            !authCont.isUserProfile.value ? 0 : SizeConfig.widthMultiplier * 55,
        decoration: BoxDecoration(
            color: ColorConstants.buttonColor,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
        padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 4,
            bottom: SizeConfig.heightMultiplier * 1.5),
        child: !authCont.isShowProfileText.value
            ? const SizedBox()
            : FadeIn(
                duration: const Duration(milliseconds: 300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SelectLangButton()),
                      const Spacer(),
                    Text(
                      authCont.userInfo?.name??'',
                        maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                    Text(
                      authCont.userInfo?.emails?[0]??'',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall!,
                    ),
                    Divider(
                        color: Colors.black,
                        height: SizeConfig.heightMultiplier * 3),
                    InkWell(
                      onTap: () {
                        authCont.isUserProfile.value = false;
                        authCont.isShowProfileText.value=false;
                        Get.dialog(ConfirmationDialog(
                            text: 'are you sure you want to logout?',
                            onConfirm: () => authCont.onLogOut()));
                      },
                      child: SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                        width: double.infinity,
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 1.8),
                        ).tr(),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
