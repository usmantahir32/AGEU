import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/models/order.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/order%20detail/order_detail.dart';
import 'package:Ageu/views/widgets/custom_tile.dart';
import 'package:Ageu/views/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTile extends StatelessWidget {
  OrderTile({
    super.key,
    required this.data,
  });

 final OrderData data;
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => Get.to(() => OrderDetailPage(
      
            orderData: data,
          )),
      child: CustomTile(
        height: SizeConfig.heightMultiplier * 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ORDER NUMBER
                    Text(
                      data.assunto!,
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 0.7),
                    //BUDGETS NUMBER
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '${data.totalItems}  ',
                          style: textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.primaryColor)),
                      TextSpan(
                          text: tr('budgets'),
                          style: textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade300))
                    ]))
                  ],
                ),
                const Spacer(),
                //MENU BUTTON
                PopupMenuButton(
                    color: ColorConstants.buttonColor,
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    itemBuilder: (_) =>
                        [const PopupMenuItem(child: Text('Test'))])
              ],
            ),
            //DIVIDER
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
              child: Divider(
                height: SizeConfig.heightMultiplier * 3,
                color: Colors.grey.shade800,
              ),
            ),
            //TYPE
            Tag(text: data.status!.display!, color: ColorConstants.primaryColor)
          ],
        ),
      ),
    );
  }
}
