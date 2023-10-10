import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.textTheme,
    required this.text,
    required this.color,
    required this.onTap,
  });
  final TextTheme textTheme;
  final String text;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstants.buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60))),
        child: SizedBox(
          height: SizeConfig.heightMultiplier * 5,
          width: SizeConfig.widthMultiplier * 30,
          child: Center(
            child: Text(
              tr(text).toUpperCase(),
              style: textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w700, color: color),
            ),
          ),
        ));
  }
}
