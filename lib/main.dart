import 'package:farmfusion_app/pages/UTS_2215091014/utsscreen.dart';
import 'package:farmfusion_app/pages/latihan_uts/uts_screen.dart';
import 'package:flutter/material.dart';
import 'package:farmfusion_app/pages/home.dart';
import 'package:farmfusion_app/pages/login.dart';
import 'package:farmfusion_app/pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmFusion',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set rute awal ke splash screen
      routes: {
        '/': (context) => SplashScreen(), // Tampilkan splash screen terlebih dahulu
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/dashboard': (context) =>  Dashboard(),
        '/lat-uts-screen': (context) => const LatUtsScreen(),
        '/uts-cs-screen' :(context) => const UtsCSScreen(),
      },
      onGenerateRoute: _onGenerateRoute, // Add this line
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (BuildContext context) {
          return const Home();
        });
      case "/login":
        return MaterialPageRoute(builder: (BuildContext context) {
          return const Login();
        });
      case "/dashboard":
        return MaterialPageRoute(builder: (BuildContext context) {
          return Dashboard();
        });
      default:
        return MaterialPageRoute(builder: (BuildContext context) {
          return Dashboard();
        });
    }
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(110, 12, 217, 139),
      body: Center(
        child: Image.asset('assets/images/logo_apk.png', width: 50, height: 50),
      ),
    );
  }
}
