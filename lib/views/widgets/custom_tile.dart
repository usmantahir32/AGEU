import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({super.key, required this.height, required this.child});
  final double height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: SizeConfig.widthMultiplier * 100,
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
      decoration: BoxDecoration(
          color: ColorConstants.inactiveButton,
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.only(
          top: SizeConfig.heightMultiplier * 2,
          bottom: SizeConfig.heightMultiplier * 1,
          left: SizeConfig.widthMultiplier * 4,
          right: SizeConfig.widthMultiplier * 2),
          child: child,
    );
  }
}
