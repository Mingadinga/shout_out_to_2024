import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SnsShareIconWidget extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  const SnsShareIconWidget(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
          iconSize: 30,
          padding: const EdgeInsets.all(8),
          style: ButtonStyle(
              iconColor: MaterialStateProperty.all<Color>(iconColor),
              backgroundColor: MaterialStateProperty.all<Color>(greyColor)),
        ),
        Text(text, style: const TextStyle(color: textColor, fontSize: 12))
      ],
    );
  }
}
