import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppTabWidget extends StatelessWidget {
  const AppTabWidget({Key? key, required this.size, required this.text, required this.color}) : super(key: key);
  final Size size;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.3,
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 7)
          ]),
      child: Center(
        child: Text(text,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 14)),
      ),
    );
  }
}
