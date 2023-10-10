import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isAdd = false,
  });
  final VoidCallback onTap;
  final String text;
  final bool isAdd;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.buttonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60))),
      child: SizedBox(
          height: isAdd
              ? SizeConfig.heightMultiplier * 4.7
              : SizeConfig.heightMultiplier * 5,
          width: isAdd
              ? SizeConfig.widthMultiplier * 36
              : SizeConfig.widthMultiplier * 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr(text).toUpperCase(),
                style: textTheme.titleSmall!.copyWith(
                    fontWeight: isAdd ? FontWeight.w800 : FontWeight.w700,
                    color: ColorConstants.primaryColor),
              ),
              SizedBox(width: !isAdd ? 0 : SizeConfig.widthMultiplier * 2),
              !isAdd
                  ? const SizedBox()
                  : Icon(Icons.add, color: ColorConstants.primaryColor)
            ],
          )),
    );
  }
}
