import 'package:flutter/material.dart';
import 'package:farmfusion_app/utils/constants.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: 1, // Ganti dengan jumlah notifikasi yang Anda miliki
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.notifications, color: Constants.secondaryColor), // Ikona notifikasi
            title: const Text('Postingan Berhasil'), // Judul notifikasi
            subtitle: const Text('Postingan Anda berhasil diunggah!'), // Isi pesan notifikasi
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Constants.secondaryColor,), // Ikona hapus notifikasi
              onPressed: () {
                // Tambahkan logika untuk menghapus notifikasi
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Notification dismissed'),
                ));
              },
            ),
            onTap: () {
              // Tambahkan logika untuk menangani ketika notifikasi ditekan
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Notification clicked'),
              ));
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationScreen(),
  ));
}
