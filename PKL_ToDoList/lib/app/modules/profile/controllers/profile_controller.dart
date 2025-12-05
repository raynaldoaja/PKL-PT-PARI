import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  var userName = ''.obs;
  var userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    userName.value = box.read('user_name') ?? 'Raynaldo';
    userEmail.value = box.read('user_email') ?? 'pari@contoh.com';
  }
}
