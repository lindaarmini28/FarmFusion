import 'package:flutter/material.dart';
import 'package:farmfusion_app/utils/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon; // Mengubah tipe data menjadi IconData
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Constants.primaryColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon, // Menggunakan ikon bawaan Flutter
              color: Constants.secondaryColor,
              size: 22, // Ubah ukuran ikon sesuai kebutuhan
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: const TextStyle(color: Constants.secondaryColor))),
            const Icon(Icons.arrow_forward_ios, color: Constants.secondaryColor, size:20 ), // Menggunakan ikon bawaan Flutter
          ],
        ),
      ),
    );
  }
}
