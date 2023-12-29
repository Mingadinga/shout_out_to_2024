import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';

class ResultWidget extends StatelessWidget {
  final String result;

  const ResultWidget(this.result, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      width: 300,
      height: 300,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          width: 300,
          height: 300,
          color: greyColor,
          padding: const EdgeInsets.all(16.0),
          child: Text(
            result,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
