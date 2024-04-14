import 'package:flutter/material.dart';
import  'package:farmfusion_app/utils/constants.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Allow Notifications'),
              trailing: Switch(
                value: true,
                focusColor: Constants.secondaryColor, // Atur nilai berdasarkan preferensi pengguna
                onChanged: (value) {
                  // Implementasi logika untuk mengubah preferensi notifikasi pengguna
                },
              ),
            ),
            ListTile(
              title: const Text('Sound Notifications'),
              trailing: Switch(
                value: true, // Atur nilai berdasarkan preferensi pengguna
                onChanged: (value) {
                  // Implementasi logika untuk mengubah preferensi suara notifikasi pengguna
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Change Password'),
              onTap: () {
                // Navigasi ke halaman untuk mengubah kata sandi
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                // Implementasi logika untuk keluar dari akun
              },
            ),
          ],
        ),
      ),
    );
  }
}
