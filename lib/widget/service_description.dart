import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';

class ServiceDescriptionWidget extends StatelessWidget {
  const ServiceDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "목표를 공유하면 더 쉽게 달성할 수 있다는\n 사실을 알고 계신가요?\n새해, 새로운 목표를 세우고 함께 나누세요!",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
    );
  }
}
