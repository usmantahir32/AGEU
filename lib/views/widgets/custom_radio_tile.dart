
import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomRadioTile extends StatelessWidget {
  const CustomRadioTile({
    super.key,
    required this.value,
    required this.onTap,
    required this.text,
  });
  final bool value;
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: SizeConfig.heightMultiplier * 2.5,
              width: SizeConfig.widthMultiplier * 4.5,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: value
                          ? ColorConstants.primaryColor
                          : Colors.grey.shade700,
                      width: 2),
                  shape: BoxShape.circle),
              child: value
                  ? Padding(
                      padding: EdgeInsets.all(2),
                      child: CircleAvatar(
                          backgroundColor: ColorConstants.primaryColor))
                  : const SizedBox(),
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 5),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
