import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeListtile extends StatelessWidget {
  HomeListtile(
      {super.key,
      required this.name,
      required this.description,
      required this.time});
  final String name;
  final String description;
  dynamic time;
  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateTime.parse(time);

    // Format to 12-hour format with AM/PM
    String formattedTime = DateFormat('hh:mm a').format(parsedDateTime);
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 224, 211, 215)),
        height: 48,
        width: 48,
        child: Icon(Icons.check),
      ),
      title: Text(
        name,
        style: GoogleFonts.epilogue(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 28, 19, 13)),
      ),
      subtitle: Text(
        description,
        style: GoogleFonts.epilogue(
            fontSize: 14, color: const Color.fromARGB(255, 150, 79, 102)),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            children: [
              Icon(Icons.camera_alt_outlined),
              Text(
                "  $formattedTime",
                style: GoogleFonts.epilogue(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 150, 79, 102)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
