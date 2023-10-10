import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/widgets/custom_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dropdown_tile.dart';

class CEPdata extends StatelessWidget {
  CEPdata({
    super.key,
    required this.state,
    required this.city,
    required this.neighborhood,
    required this.publicPlace,
  });
  final String state, city, neighborhood, publicPlace;
  final cont = Get.find<AddOrderCont>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.heightMultiplier * 46,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //STATE
          DropDownTile(
            title: 'State',
            value: state,
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),
          //CITY
          DropDownTile(
            title: 'City',
            value: city,
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),

          //NEIGHBORHOOD
          DropDownTile(
            title: 'Neighborhood',
            value: neighborhood,
          ),
          SizedBox(height: SizeConfig.heightMultiplier * 2),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropDownTile(
                title: 'Public Place',
                value: publicPlace,
                isSmall: true,
              ),
              Obx(
                ()=> DropDownTile(
                  title: 'N°',
                  value: 'Ex: 777',
                  validationText: cont.altitudeValidationText.value,
                  isSmall: true,
                  isExtraSmall: true,
                  textEditingController: cont.altitudeCont,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
