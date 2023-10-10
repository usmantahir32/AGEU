import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:flutter/material.dart';


class Tag extends StatelessWidget {
  const Tag({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 0.3),
      decoration: BoxDecoration(
        color: ColorConstants.buttonColor,
        borderRadius: BorderRadius.circular(60),
      ),
      child: Text(
        text,
        style: textTheme.bodySmall!.copyWith(
            color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
