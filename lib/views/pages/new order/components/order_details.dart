import 'dart:io';

import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/validations.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/services/cep.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/custom_inputfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'cep_data.dart';

class InputOrderDetails extends StatelessWidget {
  InputOrderDetails({
    super.key,
  });
  final cont = Get.find<AddOrderCont>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //DELIVERY ADDRESS
        Row(
          children: [
            Icon(
              FeatherIcons.mapPin,
              color: ColorConstants.primaryColor,
              size: SizeConfig.heightMultiplier * 4,
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery place',
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ).tr(),
                Text(
                  'Indicate where the order should be delivered',
                  style: textTheme.titleSmall!
                      .copyWith(fontSize: SizeConfig.textMultiplier * 1.6),
                ).tr()
              ],
            )
          ],
        ),
        SizedBox(
            height: Platform.isAndroid ? SizeConfig.heightMultiplier * 3 : SizeConfig.heightMultiplier*2),
        //CEP
        Text(
          'CEP',
          style: textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w500, color: ColorConstants.primaryColor),
        ),
        Obx(
          () => Stack(
            children: [
              CustomInputField(
                  controller: cont.cepCont,
                  hintText: 'Write CEP',
                  validationText: cont.cepValidateText.value,
                  keyBoardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  isCEP: true,
                  onSubmit: (val) => CepService.getCep(cont.cepCont.text),
                  suffix: Padding(
                    padding: const EdgeInsets.all(12),
                    child: cont.getCEPdata == null
                        ? Icon(Icons.done, color: Colors.transparent)
                        : cont.getCEPdata!.success == true
                            ? Icon(Icons.done, color: Colors.green)
                            : Icon(
                                Icons.close,
                                color: Colors.redAccent,
                              ),
                  )),
              Positioned(
                bottom: SizeConfig.heightMultiplier * 2,
                right: SizeConfig.widthMultiplier * 3,
                child: cont.getCEPdata == null && cont.cepCont.text.isNotEmpty
                    ? Container(
                        color: ColorConstants.secondaryColor,
                        height: SizeConfig.heightMultiplier * 3,
                        width: SizeConfig.widthMultiplier * 6,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                          ),
                        ),
                      )
                    :const SizedBox(),
              )
            ],
          ),
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 2),
        //GET CEP DETAILS
        Obx(() {
          final data = cont.getCEPdata;
          if (data == null || data.success == false) {
            //IF CEP NOT EMPTY OR NOT FOUND
            return CEPdata(
              state: 'State',
              city: 'City',
              neighborhood: 'Neighborhood',
              publicPlace: 'Public Place',
            );
          } else {
            return CEPdata(
              state: data.data!.state!.sigla!,
              city: data.data!.city!.nome!,
              neighborhood: data.data!.neighborhood!,
              publicPlace: data.data!.publicPlace!,
            );
          }
        }),
        SizedBox(height: SizeConfig.heightMultiplier * 1),
        Text(
          'Complement',
          style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
        ),
        Obx(
          () => CustomInputField(
            controller: cont.complementCont,
            onSubmit: (val) => val.isNotEmpty
                ? cont.complementValidateText.value = ''
                : cont.complementValidateText.value =
                    OrderValidations.complementEmpty,
            validationText: cont.complementValidateText.value,
            hintText: 'Write complement',
          ),
        ),
      ],
    );
  }
}
