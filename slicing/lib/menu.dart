import 'package:flutter/material.dart';
void main() {
  runApp(const Menu());
}
class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AccountCenter(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class AccountCenter extends StatelessWidget {
  const AccountCenter({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Akun'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('Informasi Akun'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),
            ListTile(
             leading: const Icon(Icons.security),
              title: const Text('Keamanan Akun'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
              },
            ),
            const Spacer(),
            const Text('Device Version 1.0.0.0'),
            const SizedBox(height: 16,),
            ElevatedButton.icon(
              onPressed: () {
              },
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Log out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
     ),
    );
  }
}