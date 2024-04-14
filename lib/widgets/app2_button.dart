import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

enum ButtonType { primary, plain}

class AppButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback onPressed;
  final String text;

  const AppButton(
      {required this.type, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context); // Inisialisasi ScreenUtil di dalam build
    return InkWell(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 150),
        height: ScreenUtil().setHeight(35.0),
        decoration: BoxDecoration(
          color: getButtonColor(type),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(169, 176, 185, 0.42),
              spreadRadius: 0,
              blurRadius: 8.0,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.roboto(
              color: getTextColor(type),
              fontSize: 19.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

Color getButtonColor(ButtonType type) {
  switch (type) {
    case ButtonType.primary:
      return Constants.secondaryColor;
    case ButtonType.plain:
      return Colors.white;
    default:
      return Constants.secondaryColor;
  }
}

Color getTextColor(ButtonType type) {
  switch (type) {
    case ButtonType.plain:
      return Constants.secondaryColor;
    case ButtonType.primary:
      return Colors.white;
    default:
      return Colors.white;
  }
}

