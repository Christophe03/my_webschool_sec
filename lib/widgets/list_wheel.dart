import 'package:flutter/material.dart';

class ListWheel extends StatelessWidget {
  final FixedExtentScrollController controller;
  final Color color;
  final void Function(double v) onSelectedItemChanged;
  final List<int> items;
  final String label;
  const ListWheel(
      {super.key,
      required this.color,
      required this.onSelectedItemChanged(double v),
      required this.items,
      required this.controller,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color.withOpacity(0.7)),
          width: MediaQuery.of(context).size.width - 50,
          height: 50,
          child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 40,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: items.length,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Text(items[index].toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        label,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                );
              },
            ),
            onSelectedItemChanged: (index) {
              onSelectedItemChanged(items[index].toDouble());
            },
          ),
        ),
      ],
    );
  }
}
