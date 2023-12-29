import 'package:flutter/material.dart';

class NameGoalTextWidget extends StatelessWidget {
  final String name;

  const NameGoalTextWidget(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("[ $name ]",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            )),
        const Text("의 새해 목표",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ))
      ],
    );
  }
}
