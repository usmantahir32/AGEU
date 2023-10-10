import 'package:Ageu/constants/colors.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'show_loading.dart';

class ConfirmationDialog extends GetWidget<AuthCont> {
  const ConfirmationDialog({
    Key? key,
    required this.text,
    this.isNote = false,
    this.note = '',
    required this.onConfirm,
  }) : super(key: key);
  final String text;
  final VoidCallback onConfirm;
  final bool isNote;
  final String note;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Obx(
        () => Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: SizeConfig.heightMultiplier * 15,
                width: SizeConfig.widthMultiplier * 80,
                decoration: BoxDecoration(
                    color: ColorConstants.buttonColor,
                    borderRadius: BorderRadius.circular(8)),
                child: controller.isLoading.value
                    ? const ShowLoading(
                        inAsyncCall: true,
                        opacity: 0,
                        child: SizedBox(),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 80,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.textMultiplier * 2,
                                  right: SizeConfig.widthMultiplier * 3,
                                  top: SizeConfig.heightMultiplier * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    text,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize:
                                                SizeConfig.textMultiplier *
                                                    1.8),
                                  ).tr(),
                                  SizedBox(
                                      height: SizeConfig.heightMultiplier * 1),
                                  isNote
                                      ? Text('"${note}"',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      1.3))
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text(
                                    'Go back',
                                    style: TextStyle(color: Colors.redAccent),
                                  ).tr()),
                              TextButton(
                                  onPressed: onConfirm,
                                  child: const Text('Confirm').tr()),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              )
                            ],
                          )
                        ],
                      ),
              ),
            )),
      ),
    );
  }
}
