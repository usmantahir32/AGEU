import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// RENDERS THE INDICATOR OF THE SIGNUP FLOW - THE 3 CIRCLES AT THE BOTTOM OF THE SCREEN
class DotIndicator extends StatelessWidget {
  DotIndicator({
    Key? key,
  }) : super(key: key);

  final cont = Get.find<AddOrderCont>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.widthMultiplier * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            3,
            (index) => Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: EdgeInsets.only(
                    right: index == 2 ? 0 : SizeConfig.widthMultiplier * 1),
                height: SizeConfig.heightMultiplier * 1,
                width: SizeConfig.widthMultiplier * 2.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cont.currentSection.value == index
                      ? ColorConstants.primaryColor
                      : Colors.grey.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
