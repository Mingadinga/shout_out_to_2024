import 'package:flutter/material.dart';
import 'package:shout_out_to_2024/screen/ResultShareScreen.dart';
import 'package:shout_out_to_2024/widget/goal_card.dart';

class GoalList extends StatefulWidget {
  final String name;

  const GoalList({super.key, required this.name});

  @override
  State<GoalList> createState() => _GoalListState(name);
}

class _GoalListState extends State<GoalList> {
  List<String> items = List.generate(
      5,
      (index) => DateTime.now()
          .add(Duration(milliseconds: index))
          .millisecondsSinceEpoch
          .toString());

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;
  late Map<String, GoalCardWidget> _goalCardWidgets;
  final String name;

  _GoalListState(this.name);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _goalCardWidgets = {
      for (var item in items)
        item: GoalCardWidget(
          item: item,
        )
    };
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              buildDefaultDragHandles: false,
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  final String item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);
                });
              },
              scrollController: _scrollController,
              children: [
                for (final item in items)
                  ReorderableDragStartListener(
                    index: items.indexOf(item),
                    key: ValueKey(item),
                    child: _goalCardWidgets[item] ?? Container(),
                  ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    StringBuffer buffer = StringBuffer();
                    buffer.write("[ $name ]의 새해 목표\n");
                    for (final item in items) {
                      String enteredText =
                          _goalCardWidgets[item]!.getEnteredText();
                      if (enteredText.isNotEmpty) {
                        buffer.write('- ');
                        buffer.write(enteredText += '\n');
                      }
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultShareScreen(
                          result: buffer.toString(),
                        ),
                      ),
                    );
                  },
                  child: const Text('작성 완료'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
