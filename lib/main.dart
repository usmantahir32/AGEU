import 'package:Ageu/bindings/bindings.dart';
import 'package:Ageu/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'constants/colors.dart';
import 'views/pages/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('pt', 'BR')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);

            return GetMaterialApp(
              initialBinding: AuthBindings(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(
                  fontFamily: 'Mulish',
                  textTheme: TextTheme(
                      headlineLarge: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeConfig.textMultiplier * 3,
                          color: Colors.white),
                      bodySmall: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.6,
                          color: Colors.white),
                      titleMedium: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2.2,
                          color: Colors.white),
                      titleSmall: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 1.8,
                          color: Colors.white),
                      bodyMedium: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2,
                          color: Colors.white),
                      headlineSmall: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2.2,
                          color: Colors.white)),
                  cupertinoOverrideTheme: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: SizeConfig.textMultiplier * 2.2,
                        fontWeight: FontWeight.w500),
                  )),
                  colorScheme: ThemeData().colorScheme.copyWith(
                        primary: ColorConstants.primaryColor,
                      ),
                  scaffoldBackgroundColor: ColorConstants.secondaryColor),
              debugShowCheckedModeBanner: false,
              home: const SplashPage(),
            );
          },
        );
      },
    );
  }
}
