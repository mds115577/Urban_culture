import 'package:flutter/material.dart';

Widget buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xFF814C59), // Brownish color from image
    ),
  );
}

// Helper method for text buttons
Widget buildTextButton(String label) {
  return TextButton(
    onPressed: () {},
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF814C59), // Brownish color from image
      ),
    ),
  );
}
