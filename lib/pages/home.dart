import 'package:flutter/material.dart';
import 'dart:async';

import 'package:farmfusion_app/pages/splash_content.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/widgets/app_button.dart';
import 'package:farmfusion_app/pages/create_account.dart';
import 'package:farmfusion_app/pages/login.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  late PageController _pageController;

  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to FarmFusion, Let’s shop!",
      "image": "assets/images/Splash_1.png"
    },
    {
      "text":
          "We help farmers and traders to easily connect\nacross Indonesia",
      "image": "assets/images/Splash_2.jpg"
    },
    {
      "text": "We simplify the bidding process,\nYou just need to stay at home with us",
      "image": "assets/images/Splash_3.jpg"
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]["text"],
                    image: splashData[index]["image"],
                    currentPage: currentPage,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      // Indicator dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: Constants.kAnimationDuration,
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? Constants.secondaryColor
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      // Buttons
                      AppButton(
                        text: "Log In",
                        type: ButtonType.plain,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      AppButton(
                        text: "Create an Account",
                        type: ButtonType.primary,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CreateAccount()),
                          );
                        },
                      ),
                      const Spacer(flex: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
