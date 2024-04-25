import 'package:farmfusion_app/pages/about_screen.dart';
import 'package:farmfusion_app/pages/dashboard_fragments/dashboard%20chat/dashboard_chat.dart';
import 'package:farmfusion_app/pages/dashboard_fragments/dashboard%20profil/component/notification.dart';
import 'package:farmfusion_app/pages/dashboard_fragments/dashboard%20profil/dashboard_profile.dart';
import 'package:farmfusion_app/pages/dashboard_fragments/dashboard%20search/dashboard_search.dart';
import 'package:farmfusion_app/pages/dashboard_fragments/dashboard%20seles/dashboard_sale.dart';
import 'package:farmfusion_app/pages/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/pages/header_drawer.dart';
import 'package:farmfusion_app/pages/news_feed.dart';
import 'package:farmfusion_app/pages/login.dart';
import 'package:farmfusion_app/pages/data_screen.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> _screens = [
    DashboardSearch(),
    ChatPage(),
    const SaleDashboard(),
    DashboardProfile(),
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FarmFusion",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Constants.secondaryColor,
        elevation: 0.0,
      ),
      body: _screens[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Constants.secondaryColor,
        selectedItemColor: Constants.secondaryColor,
        currentIndex: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Constants.secondaryColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Constants.secondaryColor),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, color: Constants.secondaryColor),
            label: 'Sale',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Constants.secondaryColor),
            label: 'Profile',
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              ListTile(
                leading:
                    const Icon(Icons.home, color: Constants.secondaryColor),
                title: const Text('Dashboard'),
                onTap: () {
                  setState(() {
                    activeIndex =
                        0; // Ganti indeks sesuai dengan halaman yang Anda inginkan
                  });
                  Navigator.pop(context); // Tutup drawer setelah navigasi
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications,
                    color: Constants.secondaryColor),
                title: const Text('Notification'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.task, color: Constants.secondaryColor),
                title: const Text('Task API'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const NewsFeed())); // Navigasi ke laman task 7
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.task, color: Constants.secondaryColor),
                title: const Text('Task CRUD'),
                onTap: () {
                  setState(() {
                    activeIndex =
                        2; // Ganti indeks sesuai dengan halaman yang Anda inginkan
                  });
                  Navigator.pop(context); // Tutup drawer setelah navigasi
                },
              ),
              ListTile(
                leading: 
                const Icon(Icons.task, color: Constants.secondaryColor),
                title: const Text('Task Upload Image'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DatasScreen()));
                },
              ),
              const Divider(),
              ListTile(
                leading:
                    const Icon(Icons.settings, color: Constants.secondaryColor),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingScreen()));
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.info, color: Constants.secondaryColor),
                title: const Text('About'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app,
                    color: Constants.secondaryColor),
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
