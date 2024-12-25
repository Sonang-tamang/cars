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

    _pageController = PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
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
      appBar: AppBar(
        toolbarHeight: height * 0.15,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: height * 0.15,
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: height * 0.5,
              width: width * 0.7,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _images.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    _images[index], // Use Image.asset for local images
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.2,
                  width: width * 0.2,
                  child: InkWell(
                    onTap: goto_AI,
                    child: Card(
                      color: const Color.fromARGB(255, 211, 186, 185),
                      child: Center(
                          child: Text(
                        "Voice Assistant",
                        style: TextStyle(
                          fontSize: width * 0.02,
                        ),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.2,
                ),
                SizedBox(
                  height: height * 0.2,
                  width: width * 0.2,
                  child: InkWell(
                    onTap: goto_EMI,
                    child: Card(
                      color: const Color.fromARGB(255, 210, 195, 194),
                      child: Center(
                          child: Text(
                        "EMI Calculater",
                        style: TextStyle(
                          fontSize: width * 0.02,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
