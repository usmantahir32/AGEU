import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/constants/images.dart';
import 'package:Ageu/models/budget_detail.dart';
import 'package:Ageu/services/order.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/custom_tile.dart';
import 'package:Ageu/views/widgets/no_data.dart';
import 'package:Ageu/views/widgets/show_loading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/tile.dart';

class BudgetDetailPage extends StatelessWidget {
  BudgetDetailPage({super.key, required this.budgetID, required this.index});
  final String budgetID;
  final int index;
  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$');

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
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            '${tr('Budget')} #$index',
            style:
                textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<BudgetDetailModel>(
          future: OrderService.getBudgetDetail(budgetID),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                snapshot.data == null) {
              return const Loading();
            } else if (snapshot.data!.success == false) {
              return NoData(
                  image: ImagesConstants.noRequests,
                  title: 'Error!',
                  subtitle: 'Something went wrong',
                  height: SizeConfig.heightMultiplier * 70);
            } else if (snapshot.data!.data == null) {
              return NoData(
                  image: ImagesConstants.noRequests,
                  title: 'Sorry!',
                  subtitle: 'Budget detail not found',
                  height: SizeConfig.heightMultiplier * 70);
            } else {
              final data = snapshot.data!.data;
              final address = data!.address!;
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    //DELIVERY PLACE
                    Text(
                      'Delivery place',
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ).tr(),
                    SizedBox(height: SizeConfig.heightMultiplier * 1),
                    CustomTile(
                        height: SizeConfig.heightMultiplier * 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: textTheme.titleMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ).tr(),
                            SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                            Text(
                              '${address.cep} - ${address.city} - ${address.state}\n${address.publicPlace} - ${address.numero} - ${address.neighborhood}\n“${address.complemento}”',
                              style: textTheme.titleSmall!
                                  .copyWith(color: Colors.grey.shade400),
                            ),
                          ],
                        )),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    Text(
                      'Payment methods',
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ).tr(),
                    SizedBox(height: SizeConfig.heightMultiplier * 2),
                    PaymentMethodTile(
                        heading: 'Installment',
                        portion:
                            data.payment!.installments!.portion!.toString(),
                        amount: priceFormat
                            .format(data.payment!.installments!.valor),
                        subtitle: priceFormat
                            .format(data.payment!.installments!.total),
                        onTap: () {}),
                    PaymentMethodTile(
                        heading: 'A ${tr('view')}',
                        amount: priceFormat.format(data.payment!.aVista!.valor),
                        onTap: () {})
                  ],
                ),
              );
            }
          }),
    );
  }
}
