import 'package:flutter/material.dart';

import '../dashboard profil/component/body.dart';

class DashboardProfile extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}