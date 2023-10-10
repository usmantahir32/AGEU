import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/images.dart';
import 'package:Ageu/models/budget.dart';
import 'package:Ageu/models/order.dart';
import 'package:Ageu/services/order.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/no_data.dart';
import 'package:Ageu/views/widgets/show_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'components/budgets_tile.dart';

class OrderDetailPage extends StatelessWidget {
  OrderDetailPage(
      {super.key, required this.orderData});

  final OrderData orderData;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        elevation: 0,
        leadingWidth: SizeConfig.widthMultiplier * 12,
        leading: Padding(
          padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5),
          child: const BackButton(),
        ),
        title: Row(
          children: [
            Text(
              orderData.assunto!,
              style: textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: SizeConfig.widthMultiplier * 2),
            // IconButton(
            //     onPressed: () {}, icon: const Icon(FeatherIcons.edit, size: 20))
          ],
        ),
      ),
      body: Column(children: [
        // BudgetTypeList(),
        SizedBox(height: SizeConfig.heightMultiplier * 4),
        FutureBuilder<BudgetModel>(
            future: OrderService.getBudgets(orderData.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  snapshot.data == null) {
                return SizedBox(
                  height: SizeConfig.heightMultiplier*70,
                  child: const Loading());
              } else if (snapshot.data!.success == false) {
                return NoData(
                    image: ImagesConstants.noRequests,
                    title: 'Error!',
                    subtitle: 'Something went wrong',
                    height: SizeConfig.heightMultiplier * 70);
              } else if (snapshot.data!.data!.budgets!.isEmpty) {
                return NoData(
                    image: ImagesConstants.noRequests,
                    title: 'There are no budgets yet',
                    subtitle: 'The order budgets will appear here!',
                    height: SizeConfig.heightMultiplier * 70);
              } else {
                final data = snapshot.data!.data!.budgets!;
                return ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.widthMultiplier * 5),
                    itemBuilder: (_, i) {
                      return BudgetsTile(data: data[i],index: i+1);
                    });
              }
            })
      ]),
    );
  }
}
