import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final EdgeInsets edgeInsets;
  final int maxLines;
  final int maxLength;
  late TextEditingController controller;
  late bool isEmailInput;

  TextFieldWidget(
      {Key? key,
      required this.edgeInsets,
      required this.maxLines,
      required this.maxLength,
      bool? isEmailInput})
      : super(key: key) {
    controller = TextEditingController();
    this.isEmailInput = isEmailInput ?? false;
  }

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState(
      edgeInsets, maxLines, maxLength, controller, isEmailInput);

  String getEnteredText() {
    return controller.text;
  }
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final EdgeInsets edgeInsets;
  final int maxLines;
  final int maxLength;
  final TextEditingController controller;
  final bool isEmailInput;

  _TextFieldWidgetState(this.edgeInsets, this.maxLines, this.maxLength,
      this.controller, this.isEmailInput);

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.text.length > maxLength) {
        controller.text = controller.text.substring(0, maxLength);
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    if (!controller.hasListeners) {
      controller.dispose();
    } else {
      super.dispose();
    }
  }

  String getEnteredText() {
    return controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: edgeInsets,
        child: TextField(
          controller: controller,
          minLines: 1,
          maxLines: maxLines,
          maxLength: maxLength,
          inputFormatters: isEmailInput
              ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.]+'))]
              : null,
          keyboardType:
              isEmailInput ? TextInputType.emailAddress : TextInputType.text,
        ),
      ),
    );
  }
}
