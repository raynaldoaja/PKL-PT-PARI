import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pkl_to_do_list/app/routes/app_routes.dart';
import 'app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';
void main() async {
  GetStorage.init();
   runApp(const MyApp());
} 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Day ToDo (GetX)',
      initialRoute: Routes.SPLASH,       
      getPages: AppPages.routes, 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}