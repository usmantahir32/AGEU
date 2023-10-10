import 'package:Ageu/controllers/add_order_cont.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<String?> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.find<AddOrderCont>().pickedImage.value = pickedImage.path;
      return pickedImage.path;
    } else {
      return null;
    }
  }
}
