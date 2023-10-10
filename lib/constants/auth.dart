// const String redirectURL='https://ageu.page.link?afl=https%3A%2F%2Fbackoffice.ageu.app.br%2Fcallback&apn=br.com.ageu.app&link=https%3A%2F%2Fbackoffice.ageu.app.br%2Fcallback';
import 'package:platform/platform.dart';

 String redirectURL =
   'msauth://br.com.ageu.app/VzSiQcXRmi2kyjzcA%2BmYLEtbGVs%3D';

String clientID = 'be14078b-a647-412f-948f-03029a1241ec';
String androidDiscoveryURL =
    'https://ageuauth1.b2clogin.com/ageuauth1.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_signin_signup';
String iosDiscoveryURL='https://ageuauth1.b2clogin.com/ageuauth1.onmicrosoft.com/b2c_1_signin_signup/v2.0/.well-known/openid-configuration';
List<String> scopes = [
  'openid',
  'offline_access',
  'https://ageuauth1.onmicrosoft.com/be14078b-a647-412f-948f-03029a1241ec/task.write',
  'https://ageuauth1.onmicrosoft.com/be14078b-a647-412f-948f-03029a1241ec/task.read',
  'https://ageuauth1.onmicrosoft.com/be14078b-a647-412f-948f-03029a1241ec/user.read'
];
