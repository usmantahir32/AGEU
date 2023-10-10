import 'dart:io';

import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/dialogs/add_item.dart';
import 'package:Ageu/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/bottom_page_moniter.dart';
import 'components/order_details.dart';
import 'components/order_items.dart';

class NewOrderPage extends StatelessWidget {
  NewOrderPage({super.key});
  final cont = Get.put(AddOrderCont());
  List<Widget> sections = [
    InputOrderDetails(),
    InputOrderItems(),
  ];
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        floatingActionButton: cont.currentSection.value == 1
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.heightMultiplier * 8,
                    right: SizeConfig.widthMultiplier * 3),
                child: CustomButton(
                    onTap: () => Get.dialog(AddItemDialog(isEdit: false)),
                    text: 'new item',
                    isAdd: true),
              )
            : null,
        appBar: AppBar(
          backgroundColor: ColorConstants.secondaryColor,
          elevation: 0,
          leadingWidth: SizeConfig.widthMultiplier * 40,
          leading: Padding(
            padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5),
            child: Text(
              'New Order',
              style: textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.w800),
            ).tr(),
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Padding(
                padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 5),
                child: Text(
                  'Cancel',
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ).tr(),
              ),
            ),
          ],
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Platform.isAndroid
                      ? SizeConfig.heightMultiplier * 80
                      : SizeConfig.heightMultiplier * 75,
                  width: SizeConfig.widthMultiplier * 100,
                  child: PageView.builder(
                    controller: cont.pageController,
                    physics:const NeverScrollableScrollPhysics(),
                    itemCount: sections.length,
                    onPageChanged: (val) => cont.currentSection.value = val,
                    itemBuilder: (_, i) => sections[i],
                  ),
                ),
                SizedBox(height: SizeConfig.heightMultiplier * 2),
                BottomPageMoniter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
