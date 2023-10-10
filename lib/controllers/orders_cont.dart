import 'package:Ageu/models/data.dart';
import 'package:Ageu/models/order.dart';
import 'package:Ageu/services/order.dart';
import 'package:get/get.dart';

class OrdersCont extends GetxController {
  RxInt orderTypeIndex = 0.obs;
  RxInt budgetTypeIndex = 0.obs;
  RxInt currenPage = 0.obs;
  RxString currentStatus = 'All'.obs;
  RxBool onReachesEnd = false.obs;
  Rxn<List<OrderData>> orders = Rxn<List<OrderData>>();
  List<OrderData>? get getorders => orders.value;
  orderByStatus(int index) async {
    //FOR UI
    orderTypeIndex.value = index;
    //FOR FETCH BACKEND STATUS KEYS
    currentStatus.value = orderKeys[index];
    //PAGE TO 0
    currenPage.value = 0;
    //GET ORDERS FROM PAGE 0
    orders.value = null;
    orders.value =
        await OrderService.getOrders(currenPage.value, orderKeys[index]);
    return;
  }
}
