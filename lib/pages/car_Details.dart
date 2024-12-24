// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cars/components/carPIc.dart';

import 'package:flutter/material.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final List<Map<String, dynamic>> cars = [
      {
        "assetImagePath": "assets/netav50.png",
        "title": "NETA V50",
        "details": [
          {"icon": Icons.price_check, "text": "Net V50 Rs: 38,99,000"},
          {"icon": Icons.electric_car, "text": "NEDC Range: 380 km"},
          {
            "icon": Icons.battery_charging_full,
            "text": "Battery warranty: 8 yrs/150,000 km"
          },
          {"icon": Icons.flash_on, "text": "Fast Charging: 30–80% in 20 mins"},
        ],
        "buttonText": "View Details",
      },
      {
        "assetImagePath": "assets/netavx.png",
        "title": "NETA X",
        "details": [
          {"icon": Icons.price_check, "text": "Comfort Rs: 53,99,000"},
          {"icon": Icons.electric_car, "text": "NEDC Range: 500 km"},
          {"icon": Icons.timer, "text": "Acceleration Time: 9.5 s"},
          {"icon": Icons.battery_saver, "text": "Battery Type: LFP"},
        ],
        "buttonText": "View Details"
      },
      {
        "assetImagePath": "assets/netas.png",
        "title": "NETA S",
        "details": [
          {"icon": Icons.electric_car, "text": "NEDC Range: 1100 km"},
          {"icon": Icons.drive_eta, "text": "L4 Auto Driving in some scenes"},
          {"icon": Icons.air, "text": "Active Air Suspension"},
          {"icon": Icons.flash_on, "text": "Fast Charging: 150 km in 5 min"},
        ],
        "buttonText": "View Details"
      },
      //new datails to cange
      {
        "assetImagePath": "assets/AionY.png",
        "title": "GAC Motor - Aion Y",
        "details": [
          {"icon": Icons.electric_car, "text": "NEDC Range: 1100 km"},
          {"icon": Icons.drive_eta, "text": "L4 Auto Driving in some scenes"},
          {"icon": Icons.air, "text": "Active Air Suspension"},
          {"icon": Icons.flash_on, "text": "Fast Charging: 150 km in 5 min"},
        ],
        "buttonText": "View Details"
      },
      {
        "assetImagePath": "assets/KYC.png",
        "title": "Kuayue Chana V5D",
        "details": [
          {"icon": Icons.electric_car, "text": "NEDC Range: 1100 km"},
          {"icon": Icons.drive_eta, "text": "L4 Auto Driving in some scenes"},
          {"icon": Icons.air, "text": "Active Air Suspension"},
          {"icon": Icons.flash_on, "text": "Fast Charging: 150 km in 5 min"},
        ],
        "buttonText": "View Details"
      },
      {
        "assetImagePath": "assets/King.png",
        "title": "KINGWIN EV",
        "details": [
          {"icon": Icons.electric_car, "text": "NEDC Range: 1100 km"},
          {"icon": Icons.drive_eta, "text": "L4 Auto Driving in some scenes"},
          {"icon": Icons.air, "text": "Active Air Suspension"},
          {"icon": Icons.flash_on, "text": "Fast Charging: 150 km in 5 min"},
        ],
        "buttonText": "View Details"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Cars"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.7,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cars.length,
                itemBuilder: (BuildContext context, int index) {
                  final car = cars[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: SizedBox(
                      width: width * 0.35, // Smaller card width
                      child: buildCarCard(
                        Height: height * 0.6, // Smaller card height
                        assetImagePath: car['assetImagePath'],
                        title: car['title'],
                        details:
                            List<Map<String, dynamic>>.from(car['details']),
                        buttonText: car['buttonText'],
                        onPressed: () {
                          debugPrint(
                              'View Details pressed for ${car['title']}');
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
