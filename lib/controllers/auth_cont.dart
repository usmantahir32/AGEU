import 'dart:convert';
import 'dart:io';
import 'package:Ageu/constants/data.dart';
import 'package:Ageu/constants/local_db.dart';
import 'package:Ageu/constants/auth.dart';
import 'package:Ageu/controllers/orders_cont.dart';
import 'package:Ageu/models/user_model.dart';
import 'package:Ageu/views/pages/home/home.dart';
import 'package:Ageu/views/pages/onboarding/onboarding.dart';
import 'package:Ageu/views/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as logDev;

class AuthCont extends GetxController {
  RxBool isFirstBuild = true.obs;
  RxBool isUserProfile=false.obs;
  RxBool isShowProfileText=false.obs;
  //INIT STATE
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () {
      checkUserLanguage();
      userLanguage.value = defaultLanguage;
    });
  }

  //OBSERVABLES
  RxBool isLoading = false.obs;
  RxString userAccessToken = ''.obs;
  RxString userLanguage = ''.obs;
  String get getuserAccessToken => userAccessToken.value;
  //USER MODEL
  final Rxn<UserModel> _userData = Rxn<UserModel>();
  UserModel? get userInfo => _userData.value;
  //APP AUTH
  FlutterAppAuth appauth = const FlutterAppAuth();

  //SAVE USER TOKEN
  Future<void> saveUserTokens(TokenResponse result) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      //SAVE ACCESS TOKEN
      prefs.setString(LocalDBconstants.accesstoken, result.accessToken!);
      //SAVE ID TOKEN
      prefs.setString(LocalDBconstants.idtoken, result.idToken!);
      //SAVE REFRESH TOKEN
      prefs.setString(LocalDBconstants.refreshToken, result.refreshToken!);
      //SAVE LOGIN BOOLEAN
      prefs.setBool(LocalDBconstants.userLogin, true);
      //SAVE ACCESS TOKEN IN LOCAL VARIABLE
      userAccessToken.value = result.accessToken!;
      logDev.log(userAccessToken.value);
      Get.off(HomePage());
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isUserLogin() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      //GET USER LOGIN STATUS
      bool isLogin = prefs.getBool(LocalDBconstants.userLogin) ?? false;
      //GET USER TOKEN
      userAccessToken.value =
          prefs.getString(LocalDBconstants.accesstoken) ?? '';
      logDev.log(userAccessToken.value);
      return isLogin;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //LOGIN AUTH OR SIGNUP
  Future<void> authorization() async {
    isLoading.value = true;

    AuthorizationTokenResponse? result;
    try {
      result = await appauth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(clientID, redirectURL,
            discoveryUrl:
                Platform.isAndroid ? androidDiscoveryURL : iosDiscoveryURL,
                
            promptValues: ['consent','login'],
            scopes: scopes),
      );
      if (result != null) {
        saveUserTokens(result);
      } else {
        CustomSnackbar.showCustomSnackbar(true, 'Something went wrong');
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  //REFRESH TOKEN
  Future<bool> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      String? refreshToken = prefs.getString(LocalDBconstants.refreshToken);
      if (refreshToken == null) {
        return false;
      } else {
        final response = await appauth.token(TokenRequest(
            clientID, Platform.isAndroid ? redirectURL : redirectURL,
            
            discoveryUrl:
                Platform.isAndroid ? androidDiscoveryURL : iosDiscoveryURL,
            refreshToken: refreshToken));

        if (response != null) {
          _userData.value = parseIdToken(response.idToken!);
          await saveUserTokens(response);

          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  UserModel parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    final Map<String, dynamic> json = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    return UserModel.fromJson(json);
  }

  Future<void> checkUserLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(LocalDBconstants.appLanguage) == "English") {
      Get.updateLocale(const Locale("en", "US"));
      userLanguage.value = 'English';
    } else if (prefs.getString(LocalDBconstants.appLanguage) == "Portugese") {
      Get.updateLocale(const Locale("pt", "BR"));
      userLanguage.value = 'Portugese';
    } else {
      userLanguage.value = 'English';
      Get.updateLocale(const Locale("en", "US"));
    }
  }

  //SIGNOUT
  onLogOut() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    _userData.value=null;
    isFirstBuild.value=true;
    isUserProfile.value=false;
    Get.find<OrdersCont>().orders.value=null;
    
    Get.off(()=> OnBoardingPage());
    

    isLoading.value = false;
  }
}
