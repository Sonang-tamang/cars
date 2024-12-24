import 'package:flutter/material.dart';

class CarDetailScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarDetailScreen({super.key, required this.car});

  @override
  _CarDetailScreenState createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Image
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  widget.car['assetImagePath'],
                  height: height * 0.3,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(width: 16.0), // Space between image and details
            // Car Details
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.car['title'],
                    style: TextStyle(
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ...List<Map<String, dynamic>>.from(widget.car['details']).map(
                    (detail) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(
                            detail['icon'],
                            size: 20.0,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              detail['text'],
                              style: TextStyle(
                                fontSize: height * 0.02,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("${widget.car['details']} ");
                      },
                      child: Text(" print data"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
