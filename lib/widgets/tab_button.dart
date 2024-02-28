import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String text;
  final int index;
  final TabController tabController;

  const TabButton({Key? key, required this.text, required this.index, required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        bool isSelected = tabController.index == index;
        return GestureDetector(
          onTap: () => tabController.animateTo(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.purple : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: isSelected
                  ? []
                  : [BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 5, offset: Offset(0, 2))],
            ),
            child: Text(
              text,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        );
      },
    );
  }
}
