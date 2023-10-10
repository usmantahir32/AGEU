import 'package:Ageu/constants/images.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.height,
  });
  final String image, title, subtitle;
  final double height;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height,
      width: SizeConfig.widthMultiplier * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: SizeConfig.heightMultiplier * 15,
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 3),
          Text(title, style: textTheme.titleMedium).tr(),
          SizedBox(height: SizeConfig.heightMultiplier * 1),
          Text(subtitle,
                  style: textTheme.bodySmall!.copyWith(color: Colors.grey))
              .tr()
        ],
      ),
    );
  }
}
