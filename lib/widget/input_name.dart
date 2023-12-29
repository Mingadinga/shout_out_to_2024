import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';
import 'package:shout_out_to_2024/screen/GoalListScreen.dart';
import 'package:shout_out_to_2024/widget/textfield.dart';

class InputNameWidget extends StatefulWidget {
  const InputNameWidget({super.key});

  @override
  State<InputNameWidget> createState() => _InputNameWidgetState();
}

class _InputNameWidgetState extends State<InputNameWidget> {
  final TextFieldWidget textFieldWidget = TextFieldWidget(
    edgeInsets: const EdgeInsets.only(left: 30, top: 10),
    maxLines: 1,
    maxLength: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "당신의 이름은 무엇인가요?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
        Row(
          children: [
            Expanded(child: textFieldWidget),
            IconButton(
              onPressed: () {
                String enteredName = textFieldWidget.getEnteredText();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GoalListScreen(),
                    settings: RouteSettings(arguments: enteredName),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_circle_right_outlined),
              iconSize: 30,
            )
          ],
        )
      ],
    );
  }
}
