import 'package:farmfusion_app/main.dart';
import 'package:farmfusion_app/pages/dashboard_fragments/dashboard%20profil/component/notification.dart';
import 'package:farmfusion_app/pages/dashboard_fragments/dashboard%20profil/component/help_center.dart';
import 'package:farmfusion_app/pages/setting_screen.dart';
import 'package:flutter/material.dart';
import '../component/change_profile.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: Icons.person, // Menggunakan ikon bawaan Flutter
            press: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: Icons.notifications, // Menggunakan ikon bawaan Flutter
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotificationScreen()));
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: Icons.settings, // Menggunakan ikon bawaan Flutter
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          ),
          ProfileMenu(
            text: "Help Center",
            icon: Icons.help,  // Menggunakan ikon bawaan Flutter
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCenterScreen()));
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout, // Menggunakan ikon bawaan Flutter
            press: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
            },
          ),
        ],
      ),
    );
  }
}
