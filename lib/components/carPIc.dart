import 'package:flutter/material.dart';

/// Function to build a card for displaying car details
/// Function to build a card for displaying car details
Widget buildCarCard({
  required double Height,
  required String assetImagePath,
  required String title,
  required List<Map<String, dynamic>> details,
  required String buttonText,
  VoidCallback? onPressed,
}) {
  return Card(
    elevation: 2.0, // Lower elevation to reduce visual size
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0), // Smaller padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:
            MainAxisSize.min, // Ensure the card adjusts its height dynamically
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              assetImagePath,
              width: double.infinity,
              height: Height * 0.5, // Reduced image height
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4.0), // Reduced spacing
          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.0, // Smaller font size
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0), // Reduced spacing
          // Details with Icons
          ...details.map((detail) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0), // Smaller padding
              child: Row(
                children: [
                  Icon(detail['icon'],
                      size: 16.0, color: Colors.grey), // Smaller icon size
                  const SizedBox(width: 4.0), // Reduced spacing
                  Expanded(
                    child: Text(
                      detail['text'],
                      style:
                          const TextStyle(fontSize: 12.0), // Smaller font size
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          // SizedBox(
          //   height: 20,
          // ),

          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // No padding for the button
                minimumSize:
                    const Size(0, 0), // Minimum size to reduce extra height
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                    color: Colors.blue, fontSize: 12.0), // Smaller font
              ),
            ),
          ),
        ],
      ),
    ),
  );
}