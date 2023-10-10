import 'dart:convert';
import 'dart:io';

import 'package:Ageu/constants/apis.dart';
import 'package:Ageu/controllers/auth_cont.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UploadService {
  static Future<void> uploadPhoto(String photoPath) async {
    try {
      final imageBase64 = base64Encode(File(photoPath).readAsBytesSync());
      // print(imageBase64);
      final response =
          await http.post(Uri.parse('$baseURL/api/v1/upload'), headers: {
        // 'Content-Type: multipart/form-data'
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Get.find<AuthCont>().getuserAccessToken}'
      }, body: {
        "key": basename(photoPath),
        "value": imageBase64
      });
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
