import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';
import 'package:shout_out_to_2024/screen/Preview.dart';

class PushPreviewButtonWidget extends StatelessWidget {
  const PushPreviewButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PreviewScreen(),
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: textColor,
                width: 1,
              ),
            ),
          ),
          child: const Text(
            "목표 실천에 도움이 필요하신가요?",
            style: TextStyle(
              color: textColor,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
