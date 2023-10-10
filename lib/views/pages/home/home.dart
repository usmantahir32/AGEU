import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/images.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/models/order.dart';
import 'package:Ageu/services/order.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/new%20order/new_order.dart';
import 'package:Ageu/views/widgets/confirmation_dialog.dart';
import 'package:Ageu/views/widgets/custom_button.dart';
import 'package:Ageu/views/widgets/no_data.dart';
import 'package:Ageu/views/widgets/show_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'components/appbar.dart';
import 'components/order_type_list.dart';
import 'components/order_tile.dart';
import 'components/user_profile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final orderCont = Get.find<OrdersCont>();
  final authCont = Get.find<AuthCont>();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _onInit());
  }

  _onInit() async {
    orderCont.orders.value = await OrderService.getOrders(
        orderCont.currenPage.value, orderCont.currentStatus.value);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onOrdersPagination();
      }
    });
  }

  _onOrdersPagination() async {
    orderCont.currenPage.value += 1;
    List<OrderData> orders = await OrderService.getOrders(
        orderCont.currenPage.value, orderCont.currentStatus.value);
    if (orders.isNotEmpty) {
      orderCont.orders.value!.addAll(orders);
    } else {
      orderCont.onReachesEnd.value = true;
    }
    orderCont.orders.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      //APPBAR
      appBar: HomeAppBar(textTheme: textTheme),
      //FLOATING BUTTON
      floatingActionButton: CustomButton(
        isAdd: true,
        text: 'New Order',
        onTap: () => Get.to(() => NewOrderPage()),
      ),
      //BODY
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5),
                child: Text(
                  'Orders',
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ).tr(),
              ),
              FadeIn(
                  duration: const Duration(milliseconds: 600),
                  child: OrderTypeList()),
              SizedBox(height: SizeConfig.heightMultiplier * 4),
              Obx(() {
                final data = orderCont.getorders;
                if (data == null) {
                  //LOADING
                  return const Loading();
                } else {
                  if (data.isEmpty) {
                    //NO ORDERS
                    return NoData(
                        image: ImagesConstants.noRequests,
                        title: 'There are no requests yet',
                        subtitle: 'Your orders will appear here!',
                        height: SizeConfig.heightMultiplier * 60);
                  } else {
                    //ORDERS DATA
                    return Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: data.length + 1,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.heightMultiplier * 10,
                              right: SizeConfig.widthMultiplier * 5,
                              left: SizeConfig.widthMultiplier * 5),
                          itemBuilder: (_, i) {
                            if (i == data.length) {
                              if (orderCont.onReachesEnd.value ||
                                  data.length < 5) {
                                return const SizedBox();
                              } else {
                                return const Loading();
                              }
                            }
                            return FadeIn(
                                duration: const Duration(milliseconds: 300),
                                child: OrderTile(data: data[i]));
                          }),
                    );
                  }
                }
              })
            ],
          ),
          Positioned(
              top: 0,
              right: SizeConfig.widthMultiplier * 5,
              child: UserProfile())
        ],
      ),
    );
  }
}
