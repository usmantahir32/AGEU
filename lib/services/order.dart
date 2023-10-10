import 'dart:convert';

import 'package:Ageu/constants/apis.dart';
import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/models/add_order.dart';
import 'package:Ageu/models/budget.dart';
import 'package:Ageu/models/budget_detail.dart';
import 'package:Ageu/models/order.dart';
import 'package:Ageu/views/pages/order%20created/order_created.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrderService {
  //ADD ORDER
  static Future<void> addOrder(AddOrderModel data) async {
    final cont = Get.find<AddOrderCont>();
    cont.isLoading.value = true;

    try {
      final response = await http.post(
          Uri.parse('https://ageu-api.azurewebsites.net/api/v1/pedido'),
          body: jsonEncode(data.toJson()),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Get.find<AuthCont>().getuserAccessToken}'
          });
      print(response.body);
      if (response.statusCode == 200) {
        Get.to(() => const OrderCreatedPage());
      }
      cont.isLoading.value = false;
    } catch (e) {
      cont.isLoading.value = false;
    }
  }

  //GET ORDER
  static Future<List<OrderData>> getOrders(int page, String status) async {
    final authCont = Get.find<AuthCont>();
    try {
      if (authCont.isFirstBuild.value) {
        await authCont.refreshToken();
      }

      String url = '';
      if (status == 'All' || status == 'Todos') {
        url = '$baseURL/api/v1/pedidos?pagina=$page&total=6';
      } else {
        print(status);
        url = '$baseURL/api/v1/pedidos?pagina=$page&total=6&status=$status';
      }
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthCont>().getuserAccessToken}'
      });
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        authCont.isFirstBuild.value = false;

        OrderModel orderData = OrderModel.fromJson(jsonData);
        return orderData.data!;
      } else {
        authCont.isFirstBuild.value = false;
        return [];
      }
    } catch (e) {
      authCont.isFirstBuild.value = false;

      print(e);
      return [];
    }
  }

  //GET ORDER BUDGETS
  static Future<BudgetModel> getBudgets(String orderID) async {
    try {
      final response = await http
          .get(Uri.parse('$baseURL/api/v1/pedido-avaliado/$orderID'), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthCont>().getuserAccessToken}'
      });
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return BudgetModel.fromJson(jsonData);
      } else {
        return BudgetModel();
      }
    } catch (e) {
      print(e);
      return BudgetModel();
    }
  }

  //GET ORDER BUDGET DETAIL
  static Future<BudgetDetailModel> getBudgetDetail(String budgetID) async {
    try {
      final response = await http.get(
          Uri.parse('$baseURL/api/v1/pedido/forma-pagamento/$budgetID'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Get.find<AuthCont>().getuserAccessToken}'
          });
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return BudgetDetailModel.fromJson(jsonData);
      } else {
        return BudgetDetailModel();
      }
    } catch (e) {
      print(e);
      return BudgetDetailModel();
    }
  }
}
