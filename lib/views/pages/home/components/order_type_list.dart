import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/services/order.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrderTypeList extends StatelessWidget {
  OrderTypeList({
    super.key,
  });
  final cont = Get.find<OrdersCont>();
  List<String> orderList = ['All', 'Waiting for reply', 'Answered'];
  

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      child: Row(
        children: [
          ...List.generate(
              orderList.length,
              (index) => GestureDetector(
                    onTap: () => cont.orderByStatus(index),
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(
                            top: SizeConfig.heightMultiplier * 1.5,
                            left:
                                index == 0 ? SizeConfig.widthMultiplier * 5 : 0,
                            right: SizeConfig.widthMultiplier * 3),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 4,
                            vertical: SizeConfig.heightMultiplier * 1),
                        decoration: BoxDecoration(
                          color: cont.orderTypeIndex.value == index
                              ? ColorConstants.buttonColor
                              : ColorConstants.inactiveButton,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Text(
                          orderList[index],
                          style: textTheme.titleSmall!.copyWith(
                              color: cont.orderTypeIndex.value == index
                                  ? ColorConstants.primaryColor
                                  : Colors.white,
                              fontWeight: cont.orderTypeIndex.value == index
                                  ? FontWeight.w700
                                  : FontWeight.w500),
                        ).tr(),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }

  
}
