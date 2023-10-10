import 'dart:convert';
import 'package:Ageu/constants/apis.dart';
import 'package:Ageu/constants/validations.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/models/cep.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CepService {
  // ignore: body_might_complete_normally_nullable
  static Future<CepModel?> getCep(String cep) async {
    final orderCont = Get.find<AddOrderCont>();
    try {
      if (cep.isEmpty) {
        orderCont.cepValidateText.value = OrderValidations.cepEmpty;
        return CepModel();
      } else {
        orderCont.cepData.value = null;
        orderCont.cepValidateText.value = '';
        if (cep.isNotEmpty) {
          final response =
              await http.get(Uri.parse('$baseURL/api/v1/cep/$cep'), headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Get.find<AuthCont>().getuserAccessToken}'
          });

          final jsonData = jsonDecode(response.body);
          print(jsonData);
          CepModel cepData = CepModel.fromJson(jsonData);
          orderCont.cepData.value = cepData;
          //DO VALIDATION

          if (cepData.success == true) {
            orderCont.cepValidateText.value = '';
          } else {
            orderCont.cepValidateText.value = OrderValidations.invalidCEP;
          }

          return orderCont.cepData.value ?? CepModel();
        }
      }
    } catch (e) {
      print(e);
      return CepModel();
    }
  }
}
