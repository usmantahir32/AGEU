import 'package:Ageu/constants/icons.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:Ageu/views/pages/home/home.dart';
import 'package:Ageu/views/pages/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final authCont = Get.find<AuthCont>();

  @override
  void initState() {
    super.initState();
    Get.put(OrdersCont(), permanent: true);
    Future.delayed(const Duration(seconds: 2), () async {
      if (await authCont.isUserLogin()) {
        Get.off(() => HomePage());
      } else {
        Get.off(() => OnBoardingPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'splash',
          child: Image.asset(IconConstants.appIcon,
              height: SizeConfig.heightMultiplier * 40),
        ),
      ),
    );
  }
}
