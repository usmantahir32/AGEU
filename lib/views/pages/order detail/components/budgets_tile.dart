import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/models/budget.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/budget%20detail/budget_detail.dart';
import 'package:Ageu/views/widgets/custom_tile.dart';
import 'package:Ageu/views/widgets/tag.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetsTile extends StatelessWidget {
  BudgetsTile({
    super.key,
    required this.data,
    required this.index,
  });
  final BudgetData data;
  final int index;
  final authCont = Get.find<AuthCont>();
  @override
  Widget build(BuildContext context) {
    print(authCont.userLanguage.value);
    final priceFormat = NumberFormat.currency(
        locale: authCont.userLanguage.value != 'Portugese' ? 'en-US' : 'pt-BR',
        symbol:authCont.userLanguage.value != 'Portugese' ?'\$': 'R\$');
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Get.to(
          () => BudgetDetailPage(budgetID: data.avaliacaoId!, index: index)),
      child: CustomTile(
        height: SizeConfig.heightMultiplier * 19,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //BUDGET NUMBER
                    Text(
                      '${tr('Budget')} #$index',
                      style: textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),

                    SizedBox(height: SizeConfig.heightMultiplier * 1.2),
                    //BUDGETS AMOUNT
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: '${data.payment!.installments!.portion}x ',
                          style: textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w800,
                              color: ColorConstants.greenColor)),
                      TextSpan(
                          text: priceFormat
                              .format(data.payment!.installments!.value!),
                          style: textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.w800,
                              color: ColorConstants.greenColor))
                    ]))
                  ],
                ),
                const Spacer(),
                //PURHCASE BUTTON
                Text(
                  tr('purchase').toUpperCase(),
                  style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.primaryColor),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 2,
                )
              ],
            ),
            SizedBox(height: SizeConfig.heightMultiplier * 0.5),
            Text(
              'or ${priceFormat.format(data.payment!.aVista!.value)} ${tr('a view')}',
              style:
                  textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            //DIVIDER
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
              child: Divider(
                height: SizeConfig.heightMultiplier * 3,
                color: Colors.grey.shade800,
              ),
            ),
            //TAGS
            Row(
              children: [
                Tag(
                    text:
                        '${data.totalItensAvaliado}/${data.totalItens} ${tr('items')}',
                    color: Colors.white),
                SizedBox(width: SizeConfig.widthMultiplier * 2),
                Tag(
                    text:
                        '${priceFormat.format(data.valorFrete)}  ${data.diasDeEntrega}d',
                    color: ColorConstants.greenColor),
              ],
            )
          ],
        ),
      ),
    );
  }
}
