import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/confirmation_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;
  final authCont = Get.find<AuthCont>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.secondaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: SizeConfig.heightMultiplier * 10,
      leadingWidth: SizeConfig.widthMultiplier * 70,
      leading: Padding(
        padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5),
        child: Row(children: [
          //GREETINGS
          FadeIn(
              duration: const Duration(milliseconds: 600),
              child: Text('Hello,', style: textTheme.headlineLarge).tr()),
          SizedBox(width: SizeConfig.widthMultiplier * 2),
          //USERNAME
          Obx(
            () => authCont.userInfo == null
                ? const SizedBox()
                : FadeIn(
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: SizeConfig.widthMultiplier * 40,
                      child: Text('${authCont.userInfo!.name!.split(' ')[0]}!',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: textTheme.headlineLarge!
                              .copyWith(color: ColorConstants.primaryColor)),
                    ),
                  ),
          )
        ]),
      ),
      //PROFILE BUTTON
      actions: [
        GestureDetector(
          onTap: () =>
              _onProfileTap(),
          child: Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: authCont.isUserProfile.value
                  ? SizeConfig.heightMultiplier * 4
                  : SizeConfig.heightMultiplier * 3,
              width: authCont.isUserProfile.value
                  ? SizeConfig.widthMultiplier * 10
                  : SizeConfig.widthMultiplier * 8,
              decoration: BoxDecoration(
                  color: authCont.isUserProfile.value
                      ? Colors.white
                      : ColorConstants.secondaryColor,
                  border: Border.all(
                      color: authCont.isUserProfile.value
                          ? ColorConstants.buttonColor
                          : Colors.white,
                      width: authCont.isUserProfile.value ? 4 : 1.5),
                  shape: BoxShape.circle),
              child: Icon(
                authCont.isUserProfile.value ? Icons.person : FeatherIcons.user,
                size: authCont.isUserProfile.value ? 25 : 16,
                color: authCont.isUserProfile.value
                    ? ColorConstants.secondaryColor
                    : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.widthMultiplier * 5),
      ],
    );
  }

  _onProfileTap() {
    if (authCont.isUserProfile.value) {
      authCont.isUserProfile.value = false;
      authCont.isShowProfileText.value = false;
    } else {
      authCont.isUserProfile.value = true;
      Future.delayed(
          Duration(milliseconds: 400), () => authCont.isShowProfileText.value = true);
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.heightMultiplier * 10);
}
// 