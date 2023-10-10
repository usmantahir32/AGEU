import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    this.controller,
    required this.hintText,
    this.suffix,
    this.keyBoardType = TextInputType.text,
    this.isCEP = false,
    this.onSubmit,
    required this.validationText,
  });
  final TextEditingController? controller;
  final String hintText;
  final Widget? suffix;
  final TextInputType? keyBoardType;
  final Function(String)? onSubmit;
  final bool isCEP;
  final String validationText;
  @override
  Widget build(BuildContext context) {
    final fieldBorderColor = validationText=='' ? Colors.grey : Colors.redAccent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
            TextFormField(
              keyboardType: keyBoardType,
              enabled: controller == null
                  ? false
                  : hintText == 'Delivery date'
                      ? false
                      : true,
              controller: controller,
              onFieldSubmitted: onSubmit,
              inputFormatters:
                  isCEP ? [MaskTextInputFormatter(mask: '#####-###')] : null,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                  hintText: tr(hintText),
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: SizeConfig.textMultiplier * 2),
                  isCollapsed: true,
                  suffix: suffix,
                  contentPadding: EdgeInsets.symmetric(
                      vertical:
                          suffix != null ? 0 : SizeConfig.heightMultiplier * 1),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: validationText==''?ColorConstants.primaryColor:Colors.redAccent, width: 2)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: fieldBorderColor, width: 1)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: fieldBorderColor, width: 1)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: fieldBorderColor, width: 1))),
            ),
          
        const SizedBox(height: 5),
        validationText==''
            ? const SizedBox()
            : Text(
                validationText,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 1.4,
                    color: Colors.redAccent),
              ).tr()
      ],
    );
  }
}
