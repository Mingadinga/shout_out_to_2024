import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Shout out to 2024",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          fontFamily: "Asset",
          color: textColor),
    );
  }
}
