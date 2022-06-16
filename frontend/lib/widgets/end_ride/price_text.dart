import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceText extends StatefulWidget {
  final String price;
  const PriceText({Key? key, required this.price}) : super(key: key);

  @override
  State<PriceText> createState() => _PriceTextState();
}

class _PriceTextState extends State<PriceText> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: widget.price,
        style: GoogleFonts.montserrat(
          fontSize: 36.0,
          fontWeight: FontWeight.w600,
          color: AppColors.secondaryColor,
        ),
        children: [
          TextSpan(
            text: "  Baht",
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryColor,
            ),
          )
        ]));
  }
}
