import 'dart:math';

import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/validations.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/models/add_order.dart';
import 'package:Ageu/services/order.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/order%20created/order_created.dart';
import 'package:Ageu/views/widgets/custom_inputfield.dart';
import 'package:Ageu/views/widgets/custom_radio_tile.dart';
import 'package:Ageu/views/widgets/dialog_button.dart';
import 'package:Ageu/views/widgets/show_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmOrderDialog extends StatelessWidget {
  ConfirmOrderDialog({super.key});
  final cont = Get.find<AddOrderCont>();
  TextEditingController nameCont = TextEditingController();
  TextEditingController dateCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Center(
          child: Container(
        height: SizeConfig.heightMultiplier * 52,
        width: SizeConfig.widthMultiplier * 90,
        decoration: BoxDecoration(
            color: ColorConstants.secondaryColor,
            borderRadius: BorderRadius.circular(24)),
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 2,
            horizontal: SizeConfig.widthMultiplier * 5),
        child: Obx(
          () => cont.isLoading.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Please wait...', style: textTheme.titleMedium).tr(),
                    const Loading()
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Confirm Order Creation',
                      style: textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w800),
                    ).tr(),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    Text(
                      'Once created, your order cannot be edited again.',
                      style: textTheme.bodySmall!.copyWith(color: Colors.grey),
                    ).tr(),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    CustomInputField(
                        validationText: cont.orderNameValidationText.value,
                        controller: nameCont,
                        onSubmit: (val) => val.isNotEmpty
                            ? cont.orderNameValidationText.value = ''
                            : null,
                        hintText: 'Order name'),
                    SizedBox(height: SizeConfig.heightMultiplier * 4),
                    Stack(
                      children: [
                        CustomInputField(
                          validationText: cont.deliveryDateValidationText.value,
                          controller: dateCont,
                          hintText: 'Delivery date',
                        ),
                        Positioned(
                          right: 0,
                          bottom: cont.deliveryDateValidationText.value == ''
                              ? 0
                              : SizeConfig.heightMultiplier * 2,
                          child: IconButton(
                              onPressed: () => _selectDeliveryDate(context),
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),

                    //RADIO BUTTONS
                    ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, i) => Obx(
                        () => CustomRadioTile(
                          value: i == 0
                              ? cont.deliveryPeriod.value == 'Manha'
                                  ? true
                                  : false
                              : cont.deliveryPeriod.value == 'Tarde'
                                  ? true
                                  : false,
                          text: i == 0 ? 'Manha' : 'Tarde',
                          onTap: () {
                            cont.deliveryPeriodValidationText.value = '';
                            cont.deliveryPeriod.value =
                                i == 0 ? 'Manha' : 'Tarde';
                          },
                        ),
                      ),
                    ),

                    cont.deliveryPeriodValidationText.value != ''
                        ? Text(
                            cont.deliveryPeriodValidationText.value,
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: SizeConfig.textMultiplier * 1.4),
                          ).tr()
                        : const SizedBox(),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DialogButton(
                            textTheme: textTheme,
                            text: 'edit order',
                            color: Colors.white,
                            onTap: () => _onEdit()),
                        DialogButton(
                            textTheme: textTheme,
                            text: 'confirm',
                            color: ColorConstants.primaryColor,
                            onTap: () => _onConfirm())
                      ],
                    )
                  ],
                ),
        ),
      )),
    );
  }

  _onEdit() {
    cont.currentSection.value -= 1;
    cont.orderNameValidationText.value = '';
    cont.deliveryDateValidationText.value = '';
    cont.deliveryPeriodValidationText.value = '';
    cont.deliveryPeriod.value = '';
    Get.back();
  }

  _selectDeliveryDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.light(
              surface: Colors.black,
              primary: ColorConstants.primaryColor,
              onPrimary: ColorConstants.secondaryColor,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      cont.deliveryDateValidationText.value = '';
      dateCont.text = pickedDate.toString().split(' ')[0];
    } else {
      if (dateCont.text.isEmpty)
        cont.deliveryDateValidationText.value =
            OrderValidations.deliveryDateEmpty;
      else
        cont.deliveryDateValidationText.value = '';
    }
  }

  _onConfirm() async {
    if (_validtor()) {
      cont.orderNameValidationText.value = '';
      cont.deliveryDateValidationText.value = '';
      final cepData = cont.getCEPdata!.data!;
      AddOrderModel order = AddOrderModel(
          subject: nameCont.text,
          cep: cepData.cep!,
          deliveryDate: dateCont.text,
          deliveryperiod: cont.deliveryPeriod.value,
          neighborhood: cepData.neighborhood!,
          city: cepData.city!.nome!,
          state: cepData.state!.sigla!,
          publicPlace: cepData.publicPlace!,
          items: cont.items.value!,
          numero: cepData.altitude.toString(),
          complemento: cont.complementCont.text);
      await OrderService.addOrder(order);
      cont.currentSection.value = 0;
      Get.back();
      Get.off(() => const OrderCreatedPage());
    } else {}
  }

  bool _validtor() {
    bool result = dateCont.text.isNotEmpty &&
        nameCont.text.isNotEmpty &&
        cont.deliveryPeriod.value != '';
    if (result) {
      return true;
    } else {
      if (nameCont.text.isEmpty)
        cont.orderNameValidationText.value = OrderValidations.orderNameEmpty;
      else
        cont.orderNameValidationText.value = '';
      if (dateCont.text.isEmpty)
        cont.deliveryDateValidationText.value =
            OrderValidations.deliveryDateEmpty;
      else
        cont.deliveryDateValidationText.value = '';
      if (cont.deliveryPeriod.value == '')
        cont.deliveryPeriodValidationText.value =
            OrderValidations.deliveryPeriodEmpty;
      else
        cont.deliveryPeriodValidationText.value = '';

      return false;
    }
  }
}
