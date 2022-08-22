// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final barrierY;
  final bool isThisBottomBarrier;

  MyBarrier(
      {this.barrierY,
      this.barrierHeight,
      this.barrierWidth,
      required this.isThisBottomBarrier,
      this.barrierX});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(barrierX, barrierY),
      child: Container(
        width: barrierWidth,
        height: barrierHeight,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(width: 5, color: Colors.green.shade800),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset(
          'lib/images/barrier.png',
        ),
      ),
    );
  }
}
