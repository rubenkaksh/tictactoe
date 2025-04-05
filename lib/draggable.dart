import 'dart:math';

import 'package:flutter/material.dart';

class ReorderableNumberListPage extends StatefulWidget {
  @override
  _ReorderableNumberListPageState createState() =>
      _ReorderableNumberListPageState();
}

class _ReorderableNumberListPageState extends State<ReorderableNumberListPage> {
  final List<int> n = List.generate(
      7,
      (index) =>
          Random().nextInt(100)); // Generate 7 random numbers between 0-99

  List<int> numbers = [];

  @override
  void initState() {
    super.initState();
    numbers = n;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reorderable Number List'),
      ),
      body: SizedBox(
        height: 200,
        child: ReorderableListView(
          scrollDirection: Axis.horizontal,
          // Use builder for demonstration
          padding: const EdgeInsets.all(16),
          children: [
            for (int number in numbers)
              ReorderableDragStartListener(
                key: ValueKey(number),
                index: numbers.indexOf(number),
                child: Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                  child: Text(
                    number.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ],
          onReorder: (oldIndex, newIndex) {
            bool downside = false;
            if (oldIndex < newIndex) {
              newIndex -= 1;
              downside = true;
            }
            if (!downside) {
              setState(() {
                if (numbers[newIndex] < numbers[oldIndex]) {
                  final number = numbers.removeAt(oldIndex);
                  numbers.insert(newIndex, number);
                }
              });
            }
          },
        ),
      ),
    );
  }
}
