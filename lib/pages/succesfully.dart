import 'package:flutter/material.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/pages/dashboard.dart';
import 'package:farmfusion_app/widgets/app_button.dart';

class SuccesfullyScreen extends StatelessWidget {
  const SuccesfullyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle,
                  color: Constants.secondaryColor, size: 100),
              const SizedBox(height: 20),
              const Text(
                "Account Created Successfully!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              const Text(
                "Welcome to FarmFusion! \n Where Farmers and Merchants Unite! Your one-stop destination for seamless agricultural trade.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 25),
              AppButton(
                text: "Continue",
                type: ButtonType.primary,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
