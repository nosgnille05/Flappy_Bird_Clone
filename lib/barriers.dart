// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

/*class MyBarrier extends StatelessWidget {
  final size;
  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 5, color: Colors.green.shade800),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}*/

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
      /*Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1 : -1),*/
      child: Container(
        //color: Colors.green,
        width: 75,
        /*MediaQuery.of(context).size.width * barrierWidth / 2,*/
        height: barrierHeight,
        /*MediaQuery.of(context).size.height * 3 / 4 - barrierHeight / 2,*/
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(width: 5, color: Colors.green.shade800),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
