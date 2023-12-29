import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/widget/goal_list.dart';
import 'package:shout_out_to_2024/widget/name_goal_text.dart';

class GoalListScreen extends StatelessWidget {
  const GoalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                NameGoalTextWidget(name),
                const SizedBox(height: 20),
                GoalList(
                  name: name,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
