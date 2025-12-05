import 'package:get/get.dart';
import 'package:pkl_to_do_list/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _loadInitialTodos();
    }
  void _loadInitialTodos() async {
    try { 
      print('SPLASH: _loadInitialTodos() dimulai.');
      await Future.delayed(Duration(seconds: 3));
      print('SPLASH: _loadInitialTodos() selesai. Siap navigasi.');
      Get.offAllNamed(Routes.HOME); 
    } catch (e) {
      print('SPLASH: TERJADI ERROR!');
      print(e.toString());
    }
  }
}
