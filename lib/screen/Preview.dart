import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/color/colors.dart';
import 'package:shout_out_to_2024/widget/textfield.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              _DelayedFadeInWidget(
                delay: const Duration(seconds: 0),
                child: WithPaddingWidget(
                  child: RichText(
                      text: const TextSpan(
                          text: '목표 달성을 돕는 ',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: textColor),
                          children: [
                        TextSpan(
                            text: '데일리 트래커',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                            children: [
                              TextSpan(
                                text: ' 서비스를 개발 중입니다.',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: textColor),
                              ),
                            ])
                      ])),
                ),
              ),
              _DelayedFadeInWidget(
                delay: const Duration(seconds: 1),
                child: WithPaddingWidget(
                    child:
                        Image.asset('assets/images/dailytrackerpreview.png')),
              ),
              const _DelayedFadeInText(
                delay: Duration(seconds: 3),
                text: '서비스가 출시되면 알려드릴게요.',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const _DelayedFadeInWidget(
                delay: Duration(seconds: 4),
                child: WithPaddingWidget(child: EmailInputField()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DelayedFadeInText extends StatelessWidget {
  final Duration delay;
  final String text;
  final TextStyle style;

  const _DelayedFadeInText({
    Key? key,
    required this.delay,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? _FadeInText(text: text, style: style)
            : const SizedBox.shrink();
      },
    );
  }
}

class _DelayedFadeInWidget extends StatelessWidget {
  final Duration delay;
  final Widget child;

  const _DelayedFadeInWidget({
    Key? key,
    required this.delay,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(delay),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done
            ? _FadeInWidget(child: child)
            : const SizedBox.shrink();
      },
    );
  }
}

class _FadeInText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const _FadeInText({
    Key? key,
    required this.text,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: WithPaddingWidget(child: Text(text, style: style)),
        );
      },
    );
  }
}

class _FadeInWidget extends StatelessWidget {
  final Widget child;

  const _FadeInWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }
}

class WithPaddingWidget extends StatelessWidget {
  final Widget child;
  const WithPaddingWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: child,
    );
  }
}

class EmailInputField extends StatefulWidget {
  const EmailInputField({
    super.key,
  });

  @override
  State<EmailInputField> createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  bool _loading = false;

  var textFieldWidget = TextFieldWidget(
    maxLength: 50,
    maxLines: 1,
    edgeInsets: const EdgeInsets.symmetric(vertical: 10),
    isEmailInput: true,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("연락 드릴 이메일을 남겨주세요.",
              style: TextStyle(
                  fontSize: 21, fontWeight: FontWeight.w500, color: textColor)),
        ),
        Row(
          children: [
            Expanded(
              child: textFieldWidget,
            ),
            IconButton(
              onPressed: () async {
                String enteredText = textFieldWidget.getEnteredText();
                if (isValidEmail(enteredText)) {
                  await sendEmailLog(enteredText, context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('유효한 이메일 형식이 아닙니다.'),
                    ),
                  );
                }
              },
              icon: _loading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    )
                  : const Icon(Icons.input_outlined),
            ),
          ],
        ),
      ],
    );
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
        caseSensitive: false);
    return emailRegex.hasMatch(email);
  }

  Future<void> sendEmailLog(String email, BuildContext context) async {
    var url = dotenv.get('EMAIL_LOGGING_URL');
    final headers = {
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Access-Control-Allow-Origin': '*'
    };
    final body = jsonEncode({'email': email});

    const maxRetryCount = 3;
    int retryCount = 0;

    while (retryCount < maxRetryCount) {
      try {
        showLoading();

        final response =
            await http.post(Uri.parse(url), headers: headers, body: body);

        if (response.statusCode == 200) {
          hideLoading();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('신청이 완료되었습니다. 감사합니다!'),
            ),
          );
          return;
        }

        retryCount++;
      } catch (e) {
        retryCount++;
      }
    }

    hideLoading();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('이메일 로깅에 실패했습니다. 잠시 후 다시 시도해주세요.'),
      ),
    );
  }

  void showLoading() {
    setState(() {
      _loading = true;
    });
  }

  void hideLoading() {
    setState(() {
      _loading = false;
    });
  }
}
