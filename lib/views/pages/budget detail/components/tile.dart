import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/custom_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    this.subtitle,
    required this.heading,
    required this.amount,
    required this.onTap,
    this.portion,
  });
  final String heading, amount;
  final String? subtitle, portion;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomTile(
        height: subtitle == null
            ? SizeConfig.heightMultiplier * 10
            : SizeConfig.heightMultiplier * 14,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      heading,
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ).tr(),
                    SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: portion != null ? '${portion}x ' : '',
                          style: textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w800,
                              color: ColorConstants.greenColor)),
                      TextSpan(
                          text: amount,
                          style: textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w800,
                              color: ColorConstants.greenColor))
                    ]))
                  ],
                ),
                const Spacer(),
                //PURHCASE BUTTON
                TextButton(
                    onPressed: () {},
                    child: Text(
                      tr('Proceed'),
                      style: textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.primaryColor),
                    ))
              ],
            ),
            SizedBox(
                height:
                    subtitle == null ? 0 : SizeConfig.heightMultiplier * 0.5),
            subtitle == null
                ? const SizedBox()
                : Text(
                    'or $subtitle ${tr('a view')}',
                    style: textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
          ],
        ));
  }
}
