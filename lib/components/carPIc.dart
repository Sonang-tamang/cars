import 'package:flutter/material.dart';

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
        mainAxisSize: MainAxisSize.min, // Dynamically adjusts the card height
        children: [
          // Image Section with Error Handling
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              assetImagePath,
              width: double.infinity,
              height: Height * 0.5, // Reduced image height
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: Height * 0.5,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.broken_image,
                    size: 48.0,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 4.0), // Reduced spacing
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: Height * 0.05, // Smaller font size
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
                      style: TextStyle(
                          fontSize: Height * 0.04), // Smaller font size
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onPressed ?? () {}, // Fallback to prevent null errors
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // No padding for the button
                minimumSize:
                    const Size(0, 0), // Minimum size to reduce extra height
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Compact tap size
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: Height * 0.06), // Smaller font
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
