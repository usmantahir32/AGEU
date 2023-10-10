// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DynamicLinkService {
//   static Future<String> createDynamicLink(String id) async {
//     FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//       uriPrefix: 'https://ageu.page.link',
//       link: Uri.parse('https://backoffice.ageu.app.br'),
//       androidParameters: AndroidParameters(
//           packageName: 'br.com.ageu.app',
//           // minimumVersion: 125,
//         ),
//       // iosParameters: IosParameters(
        
//       //     bundleId: 'com.booking.nibbles',
//       //     // minimumVersion: '1.0.1',
//       //     appStoreId: '6446055325',
//       // ),
//     );

//     final link =await  dynamicLinks.buildLink(parameters);
// print(link);
//     return link.toString();
//   }

//   static Future<void> initDynamicLink(BuildContext context) async {
//     FirebaseDynamicLinks.instance.onLink;
//     PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     if (data != null) {
//       print('REDIRECT');

      
//     }
//   }

// }
