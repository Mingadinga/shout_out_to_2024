import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';
import 'package:shout_out_to_2024/widget/textfield.dart';

class GoalCardWidget extends StatefulWidget {
  final String item;
  late TextFieldWidget goalInputField;

  GoalCardWidget({Key? key, required this.item}) : super(key: key) {
    goalInputField = TextFieldWidget(
      edgeInsets: const EdgeInsets.symmetric(horizontal: 10),
      maxLength: 50,
      maxLines: 2,
    );
  }

  String getEnteredText() {
    return goalInputField.getEnteredText();
  }

  @override
  State<GoalCardWidget> createState() => _GoalCardWidgetState();
}

class _GoalCardWidgetState extends State<GoalCardWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        key: ValueKey(widget.item),
        leading: const Icon(
          Icons.drag_handle,
          color: iconColor,
        ),
        title: widget.goalInputField);
  }
}
