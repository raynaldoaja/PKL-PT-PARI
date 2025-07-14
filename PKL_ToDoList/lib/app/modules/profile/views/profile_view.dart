import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: const Color(0xFF8e7fd4),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8e7fd4),
              Color(0xFFc0a5d4),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 80, color: Color(0xFF8e7fd4)),
              ),
              const SizedBox(height: 20),
              Obx(() => Text(
                    'Nama: ${controller.userName.value}',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              const SizedBox(height: 10),
              Obx(() => Text(
                    'Email: ${controller.userEmail.value}',
                    style:
                        const TextStyle(fontSize: 18, color: Colors.white70),
                  )),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final TextEditingController nameController =
                      TextEditingController(
                          text: controller.userName.value);
                  Get.defaultDialog(
                    title: "Ubah Nama",
                    content: TextField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(hintText: "Nama Baru"),
                    ),
                    textConfirm: "Simpan",
                    textCancel: "Batal",
                    onConfirm: () {
                      final newName = nameController.text.trim();
                      if (newName.isNotEmpty) {
                        controller.userName.value = newName;
                        controller.box.write('user_name', newName); // ✅ Simpan ke GetStorage
                      }
                      Get.back();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF673AB7),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Ubah Profil',
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
