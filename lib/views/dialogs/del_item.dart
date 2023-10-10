import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/dialog_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DelItemDialog extends StatelessWidget {
  DelItemDialog({super.key, required this.index});
  final int index;
  final cont = Get.find<AddOrderCont>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: SizeConfig.heightMultiplier * 20,
          width: SizeConfig.widthMultiplier * 90,
          decoration: BoxDecoration(
              color: ColorConstants.secondaryColor,
              borderRadius: BorderRadius.circular(24)),
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.heightMultiplier * 2,
              horizontal: SizeConfig.widthMultiplier * 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delete Item',
                style:
                    textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w800),
              ).tr(),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Text(
                '${tr('Are you sure you want to delete the')} "${cont.items.value![index].descricao}"?',
                style: textTheme.titleSmall,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DialogButton(
                      textTheme: textTheme,
                      text: 'Cancel',
                      color: Colors.white,
                      onTap: () => Get.back()),
                  DialogButton(
                      textTheme: textTheme,
                      text: 'Delete',
                      color: ColorConstants.primaryColor,
                      onTap: () => _onDelete())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _onDelete() {
    cont.items.value!.removeAt(index);
    cont.items.refresh();
    Get.back();
  }
}
