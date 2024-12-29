// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:cars/components/dual_screen_controller.dart';
import 'package:cars/pages/car_Details.dart';
import 'package:cars/pages/recordingScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DualScreenController dualScreenController = DualScreenController();

  late PageController _pageController;
  int _currentPage = 0;
  final List<String> _images = [
    'assets/netav50.png',
    'assets/netavx.png',
    'assets/netas.png',
    'assets/AionY.png',
    'assets/King.png',
    'assets/KYC.png'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dualScreenController.showVideoOnSecondaryScreen("sample_video");
    });

    // _pageController = PageController(initialPage: 0);
    // Timer.periodic(Duration(seconds: 3), (Timer timer) {
    //   if (_currentPage < _images.length - 1) {
    //     _currentPage++;
    //   } else {
    //     _currentPage = 0;
    //   }

    //   _pageController.animateToPage(
    //     _currentPage,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    // });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: height * 0.9,
              width: width * 0.4,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(300),
                    topLeft: Radius.circular(100)),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: height * 0.15,
                          child: Image.asset(
                            "assets/logo.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: height * 0.1),
                // Title
                Text(
                  "Innovation meets performance. \nDrive the future \nOwn the innovation.",
                  style: TextStyle(
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Text(
                  "Drive Smart, Drive CG Motors!",
                  style: TextStyle(
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Discover our range of electric and fuel-efficient \nvehicles designed to drive the future.",
                  style: TextStyle(fontSize: width * 0.015, color: Colors.grey),
                ),
                SizedBox(height: height * 0.07),
                Row(
                  children: [
                    // ElevatedButton(
                    //   onPressed: () {
                    //     goto_EMI();
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Color.fromARGB(255, 141, 136, 135),
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 20, vertical: 15),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //   ),
                    //   child: const Text(
                    //     "Explore Cars",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),

                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.2,
                      child: InkWell(
                        onTap: goto_EMI,
                        child: Card(
                          color: const Color.fromARGB(255, 141, 136, 135),
                          child: Center(
                              child: Text(
                            "Explore Cars",
                            style: TextStyle(
                                fontSize: width * 0.02, color: Colors.white),
                          )),
                        ),
                      ),
                    ),

                    // second button################

                    SizedBox(
                      width: width * 0.07,
                    ),

                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.2,
                      child: InkWell(
                        onTap: goto_AI,
                        child: Card(
                          color: const Color.fromARGB(255, 141, 136, 135),
                          child: Center(
                              child: Text(
                            "Voice Assistant",
                            style: TextStyle(
                                fontSize: width * 0.02, color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Car Image
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/netav50.png',
              height: height * 0.5,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  void goto_AI() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Recording()),
    );
  }

  void goto_EMI() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CarDetails()),
    );
  }
}
