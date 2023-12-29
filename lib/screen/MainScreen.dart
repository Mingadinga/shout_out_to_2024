import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/widget/input_name.dart';
import 'package:shout_out_to_2024/widget/logo.dart';
import 'package:shout_out_to_2024/widget/service_description.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xFF9ACDF9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 300,
              height: 500,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoWidget(),
                    SizedBox(height: 16),
                    ServiceDescriptionWidget(),
                    SizedBox(height: 40),
                    InputNameWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
