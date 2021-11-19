import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDecoration {
  InputDecoration searchFieldDecoration({String hintTextStr = ""}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.black.withOpacity(0.5),
      hintText: hintTextStr,
      isDense: true,
      suffixIcon: const Icon(
        Icons.search,
        color: Colors.white,
        size: 20,
      ),
      hintStyle: GoogleFonts.raleway(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  InputDecoration textFieldDecoration({String hintTextStr = ""}) {
    return InputDecoration(
        hintText: hintTextStr,
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        hintStyle: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide.none));
  }
}
