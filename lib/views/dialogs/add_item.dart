import 'dart:convert';
import 'dart:io';

import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/validations.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/models/add_order.dart';
import 'package:Ageu/services/image_picker.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/new%20order/components/dropdown_tile.dart';
import 'package:Ageu/views/widgets/custom_inputfield.dart';
import 'package:Ageu/views/widgets/custom_snackbar.dart';
import 'package:Ageu/views/widgets/dialog_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key, required this.isEdit, this.item, this.index});
  final bool isEdit;
  final int? index;
  final Item? item;
  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final cont = Get.find<AddOrderCont>();
  TextEditingController itemNameCont = TextEditingController();
  TextEditingController qtyCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _getItemDetail();
    }
  }

  _getItemDetail() {
    itemNameCont.text = widget.item!.descricao;
    qtyCont.text = widget.item!.quantidade;
    cont.selectedMeasure.value = widget.item!.tipoUnidade;
    if (widget.item!.anexo != '') {
      cont.pickedImage.value = 'image';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: SizeConfig.heightMultiplier * 44,
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
                'Item Name',
                style:
                    textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500),
              ).tr(),
              Obx(
                () => CustomInputField(
                  controller: itemNameCont,
                  validationText: cont.itemNameValidationText.value,
                  hintText: 'Ex: Cimento ABC',
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => DropDownTile(
                      title: 'Measure',
                      value: cont.selectedMeasure.value,
                      isSmall: true,
                      isExtraSmall: true,
                    ),
                  ),
                  Obx(
                    () => DropDownTile(
                      title: 'Qtd',
                      textEditingController: qtyCont,
                      isExtraSmall: true,
                      validationText: cont.itemQtyValidationText.value,
                      isSmall: true,
                      value: 'Ex: 54',
                    ),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1),
              GestureDetector(
                onTap: () => ImagePickerService.selectImage(),
                child: Obx(
                  () => Stack(
                    children: [
                      CustomInputField(
                        validationText: '',
                        hintText: cont.pickedImage.value != ''
                            ? '1x ${tr('Photo')}'
                            : 'Photo (Optional)',
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                              cont.pickedImage.value != ''
                                  ? FeatherIcons.edit
                                  : FeatherIcons.uploadCloud,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 1),
              Text(
                'This can help warehouses more easily identify the item.',
                style: textTheme.bodySmall,
              ).tr(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DialogButton(
                      textTheme: textTheme,
                      text: 'cancel',
                      color: Colors.white,
                      onTap: () {
                        _onClearValues();
                        Get.back();
                      }),
                  DialogButton(
                      textTheme: textTheme,
                      text: 'save',
                      color: ColorConstants.primaryColor,
                      onTap: () => widget.isEdit ? _onEdit() : _onSave())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _onClearValues() {
    cont.itemNameValidationText.value = '';
    cont.itemQtyValidationText.value = '';
    cont.pickedImage.value = '';
    cont.selectedMeasure.value = 'Metro';
    itemNameCont.clear();
    qtyCont.clear();
  }

  _onSave() async {
    if (_validator()) {
      String imageBase64 = '';
      if (cont.pickedImage.value != '') {
        imageBase64 =
            base64Encode(File(cont.pickedImage.value).readAsBytesSync());
      }
      const uuid = Uuid();

      Item item = Item(
          id: uuid.v4(),
          anexo: imageBase64,
          descricao: itemNameCont.text,
          quantidade: qtyCont.text,
          tipoUnidade: cont.selectedMeasure.value);
      cont.items.value!.add(item);
      cont.items.refresh();
      Get.back();
    }
  }

  _onEdit() {
    if (_validator()) {
      String imageBase64 = '';
      if (cont.pickedImage.value != '') {
        imageBase64 =
            base64Encode(File(cont.pickedImage.value).readAsBytesSync());
      } else {
        imageBase64 = widget.item!.anexo;
      }
      Item item = Item(
          id: widget.item!.id,
          anexo: imageBase64,
          descricao: itemNameCont.text,
          quantidade: qtyCont.text,
          tipoUnidade: cont.selectedMeasure.value);
      cont.items.value![widget.index!] = item;
      cont.items.refresh();
      Get.back();
    }
  }

  bool _validator() {
    bool result = itemNameCont.text.isNotEmpty && qtyCont.text.isNotEmpty;
    if (result) {
      cont.itemNameValidationText.value = '';
      cont.itemQtyValidationText.value = '';
      return true;
    } else {
      if (itemNameCont.text.isEmpty)
        cont.itemNameValidationText.value = OrderValidations.itemNameEmpty;
      else
        cont.itemNameValidationText.value = '';

      if (qtyCont.text.isEmpty)
        cont.itemQtyValidationText.value = OrderValidations.itemQtyEmpty;
      else
        cont.itemQtyValidationText.value = '';
      return false;
    }
  }
}
