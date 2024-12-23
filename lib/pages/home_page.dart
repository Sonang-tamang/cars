// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cars/pages/EMI.dart';
import 'package:cars/pages/car_Details.dart';
import 'package:cars/pages/recordingScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CG Motors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to CG Motors!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),

            // optyion to navigate

            SizedBox(
              height: height * 0.2,
              width: width * 0.4,
              child: InkWell(
                onTap: goto_AI,
                child: Card(
                  color: Colors.green,
                  child: Center(child: Text(" Talk with AI")),
                ),
              ),
            ),

            SizedBox(
              height: height * 0.02,
            ),

            // go to EMI calculater

            SizedBox(
              height: height * 0.2,
              width: width * 0.4,
              child: InkWell(
                onTap: goto_EMI,
                child: Card(
                  color: Colors.red,
                  child: Center(child: Text("Clculate you EMI")),
                ),
              ),
            ),

            // car details

            SizedBox(
              height: height * 0.2,
              width: width * 0.4,
              child: InkWell(
                onTap: goto_carDetails,
                child: Card(
                  color: Colors.blue,
                  child: Center(child: Text("Car details")),
                ),
              ),
            )
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
      MaterialPageRoute(builder: (context) => Emi()),
    );
  }

  void goto_carDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CarDetails()),
    );
  }
}
