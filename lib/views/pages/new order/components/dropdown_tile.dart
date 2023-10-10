import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/data.dart';
import 'package:Ageu/constants/validations.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownTile extends StatelessWidget {
  DropDownTile(
      {super.key,
      required this.title,
      required this.value,
      this.validationText = '',
      // this.onTap,
      this.isSmall = false,
      this.isExtraSmall = false,
      this.textEditingController});
  final String title, value;
  final String validationText;
  // final VoidCallback? onTap;
  final bool isSmall;
  final bool isExtraSmall;
  final TextEditingController? textEditingController;
  final cont = Get.find<AddOrderCont>();
  @override
  Widget build(BuildContext context) {
    final isMeasure = title == 'Measure';
    final isTextField = textEditingController != null;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: isSmall
          ? isExtraSmall
              ? SizeConfig.widthMultiplier * 30
              : SizeConfig.widthMultiplier * 55
          : SizeConfig.widthMultiplier * 90,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
              ).tr(),
              SizedBox(height: SizeConfig.heightMultiplier * 1.2),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !isTextField
                          ? Text(
                              value,
                              style: textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier * 2),
                            )
                          : Expanded(
                              child: TextField(
                                keyboardType:title == 'N°'?TextInputType.text: TextInputType.numberWithOptions(signed: true,decimal: true),
                                controller: textEditingController,
                                onSubmitted: (val) {
                                  if (val.isNotEmpty) {
                                    cont.altitudeValidationText.value = '';
                                  } else {
                                    cont.altitudeValidationText.value =
                                        title == 'N°'
                                            ? OrderValidations.altitudeEmpty
                                            : OrderValidations.itemQtyEmpty;
                                  }
                                },
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    hintText: '$value',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade600),
                                    border: InputBorder.none),
                              ),
                            ),
                    isTextField?SizedBox():  Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: isTextField
                            ? ColorConstants.secondaryColor
                            : Colors.grey,
                      )
                    ],
                  ),
                  !isMeasure
                      ? const SizedBox()
                      : Container(
                          color: ColorConstants.secondaryColor,
                          height: SizeConfig.heightMultiplier * 3,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                value: Get.find<AddOrderCont>()
                                    .selectedMeasure
                                    .value,
                                isExpanded: true,
                                dropdownColor: ColorConstants.secondaryColor,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Mulish",
                                  fontSize: SizeConfig.textMultiplier * 1.8,
                                ),
                                items: measuresList.map(buildMenuItem).toList(),
                                onChanged: (value) => Get.find<AddOrderCont>()
                                    .selectedMeasure
                                    .value = value ?? ""),
                          ),
                        )
                ],
              ),
              Divider(
                height: isTextField
                    ? SizeConfig.heightMultiplier * 4
                    : SizeConfig.heightMultiplier * 3,
                color: validationText == '' ? Colors.grey : Colors.redAccent,
                thickness: 1.1,
              ),
            ],
          ),
          !isTextField
              ? const SizedBox()
              : validationText == ''
                  ? const SizedBox()
                  : Positioned(
                      bottom: 0,
                      child: Text(
                        validationText,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.4,
                            color: Colors.redAccent),
                      ).tr(),
                    )
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
        value: item,
        child: Text(item,
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.8,
            )));
  }
}
