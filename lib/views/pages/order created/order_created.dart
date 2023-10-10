import 'package:Ageu/constants/images.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCreatedPage extends StatelessWidget {
  const OrderCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImagesConstants.orderCreated,
            height: SizeConfig.heightMultiplier * 15,
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 3),
          Text('Order created successfully!', style: textTheme.titleMedium)
              .tr(),
          SizedBox(height: SizeConfig.heightMultiplier * 1),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 12),
            child: Text(
                    'Deposits will have up to 15 days to offer quotes for your order.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall!.copyWith(color: Colors.grey))
                .tr(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.heightMultiplier * 5,
                horizontal: SizeConfig.widthMultiplier * 25),
            child: CustomButton(
                onTap: () {
                  Get.back();
                  Get.back();
                  Get.find<OrdersCont>().orderByStatus(0);
                },
                text: 'see my orders'),
          )
        ],
      ),
    );
  }
}
