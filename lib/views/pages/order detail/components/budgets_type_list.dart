import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BudgetTypeList extends StatelessWidget {
  BudgetTypeList({
    super.key,
  });
  final cont = Get.find<OrdersCont>();
  List<String> budgetList = ['Answers', 'Order Details'];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        ...List.generate(
            budgetList.length,
            (index) => GestureDetector(
                  onTap: () => cont.budgetTypeIndex.value = index,
                  child: Obx(
                    () => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier * 1.5,
                          left: index == 0 ? SizeConfig.widthMultiplier * 5 : 0,
                          right: SizeConfig.widthMultiplier * 3),
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 4,
                          vertical: SizeConfig.heightMultiplier * 1),
                      decoration: BoxDecoration(
                        color: cont.budgetTypeIndex.value == index
                            ? ColorConstants.buttonColor
                            : ColorConstants.inactiveButton,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Text(
                        budgetList[index],
                        style: textTheme.titleSmall!.copyWith(
                            color: cont.budgetTypeIndex.value == index
                                ? ColorConstants.primaryColor
                                : Colors.white,
                            fontWeight: cont.budgetTypeIndex.value == index
                                ? FontWeight.w700
                                : FontWeight.w500),
                      ),
                    ),
                  ),
                ))
      ],
    );
  }
}
