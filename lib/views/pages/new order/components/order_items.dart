import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/images.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/models/add_order.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/dialogs/add_item.dart';
import 'package:Ageu/views/dialogs/del_item.dart';
import 'package:Ageu/views/widgets/no_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class InputOrderItems extends StatelessWidget {
  InputOrderItems({super.key});
  final cont = Get.find<AddOrderCont>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              FeatherIcons.clipboard,
              color: ColorConstants.primaryColor,
              size: SizeConfig.heightMultiplier * 4,
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Items',
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ).tr(),
                Text(
                  'Add the items to be quoted',
                  style: textTheme.titleSmall!
                      .copyWith(fontSize: SizeConfig.textMultiplier * 1.6),
                ).tr()
              ],
            )
          ],
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 3),
        Text(
          'Items',
          style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
        ).tr(),
        SizedBox(height: SizeConfig.heightMultiplier * 3),
        Obx(
          () => cont.items.value!.isEmpty
              ? NoData(
                  image: ImagesConstants.noItems,
                  title: 'There are no items yet',
                  subtitle: 'Your registered items will appear here!',
                  height: SizeConfig.heightMultiplier * 60)
              : Expanded(
                child: ListView.builder(
                    itemCount: cont.items.value!.length,
                    padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier*8),
                    shrinkWrap: true,
                    itemBuilder: (_, i) =>
                        ItemTile(data: cont.items.value![i], index: i),
                  ),
              ),
        )
      ],
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.data, required this.index});
  final Item data;
  final int index;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: SizeConfig.heightMultiplier * 8,
      width: SizeConfig.widthMultiplier * 90,
      margin: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 1),
      decoration: BoxDecoration(
          color: ColorConstants.inactiveButton,
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.only(
          bottom: SizeConfig.heightMultiplier * 1,
          top: SizeConfig.heightMultiplier * 1,
          right: SizeConfig.widthMultiplier * 1,
          left: SizeConfig.widthMultiplier * 5),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.descricao,
                style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.textMultiplier * 2),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: '${data.quantidade}  ',
                    style: textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.primaryColor,
                        fontSize: SizeConfig.textMultiplier * 2)),
                TextSpan(
                    text: data.tipoUnidade,
                    style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.grey)),
              ]))
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () => Get.dialog(AddItemDialog(
                    isEdit: true,
                    item: data,
                    index: index,
                  )),
              icon: const Icon(FeatherIcons.edit, color: Colors.white)),
          IconButton(
              onPressed: () => Get.dialog(DelItemDialog(index: index)),
              icon: const Icon(FeatherIcons.trash, color: Colors.white))
        ],
      ),
    );
  }
}
