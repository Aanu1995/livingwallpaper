import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class NoImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "No Images Available for the search Item",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(fontSize: 18.0),
        ),
      ),
    );
  }
}
