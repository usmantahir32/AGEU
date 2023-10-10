import 'package:Ageu/constants/validations.dart';
import 'package:Ageu/models/add_order.dart';
import 'package:Ageu/models/cep.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrderCont extends GetxController {
  //VALIDATORS
  RxString cepValidateText = ''.obs;
  RxString complementValidateText = ''.obs;
  RxString altitudeValidationText = ''.obs;
  RxString itemNameValidationText = ''.obs;
  RxString itemQtyValidationText = ''.obs;
  RxString orderNameValidationText = ''.obs;
  RxString deliveryDateValidationText = ''.obs;
  RxString deliveryPeriodValidationText=''.obs;
  //TEXT CONTROLLERS
  TextEditingController cepCont = TextEditingController();
  TextEditingController altitudeCont = TextEditingController();
  TextEditingController complementCont = TextEditingController();
  //LOADING
  RxBool isLoading = false.obs;

  //PAGE CONTROLLER
  PageController pageController = PageController(initialPage: 0);
  //OBSERVABLES VARIABLES
  RxInt currentSection = 0.obs;
  Rxn<List<Item>> items = Rxn<List<Item>>();
  RxString deliveryPeriod = ''.obs;
  RxString selectedMeasure = 'Metro'.obs;

  RxString pickedImage = ''.obs;
  //CEP DATA
  Rxn<CepModel> cepData = Rxn<CepModel>();
  CepModel? get getCEPdata => cepData.value;

  // CEP VALIDATOR
  bool deliveryValidator() {
    bool result = cepCont.text.isNotEmpty &&
        complementCont.text.isNotEmpty &&
        getCEPdata?.data != null &&
        altitudeCont.text.isNotEmpty;
    if (result) {
      return true;
    } else {
      if (altitudeCont.text.isEmpty) {
        altitudeValidationText.value = OrderValidations.altitudeEmpty;
      } else {
        altitudeValidationText.value = '';
      }
      if (complementCont.text.isEmpty) {
        complementValidateText.value = OrderValidations.complementEmpty;
      } else {
        complementValidateText.value = '';
      }
      if (cepCont.text.isEmpty) {
        cepValidateText.value = OrderValidations.cepEmpty;
      } else {
        if(getCEPdata?.success==true){
          cepValidateText.value='';
        }
      }
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    items.value = [];
  }
}
