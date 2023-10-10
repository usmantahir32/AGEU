
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:get/get.dart';

class AuthBindings extends Bindings {  
  @override
  void dependencies() {
    Get.lazyPut<AuthCont>(() => AuthCont());
  }
}
