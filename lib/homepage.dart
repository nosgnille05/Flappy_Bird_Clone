//ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'package:flappy_bird_clone/barriers.dart';
import 'package:flappy_bird_clone/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Bird Variables
  static double birdYaxis = 0;
  double time = 0, height = 0, initialHeight = birdYaxis, velocity = 2.8;
  double birdWidth = 0.1, birdHeight = 0.1;

  //Game Variables
  bool gameStarted = false;
  int gameScore = 0;
  int highScore = 0;

  //Barrier Variables
  static double barrierXone = 1.7;
  static double barrierXtwo = barrierXone + 1.7;
  //Updated Barrier Variables
  static List<double> barrierX = [1.7, 1.7 + 1.7];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + velocity * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });

      moveMap();

      /*setState(() {
        if (barrierXone < -1.7) {
          barrierXone += 3.4;
        } else {
          barrierXone -= 0.05;
        }
      });

      setState(() {
        if (barrierXtwo < -1.7) {
          barrierXtwo += 3.4;
        } else {
          barrierXtwo -= 0.05;
        }
      });*/

      if (birdIsDead()) {
        timer.cancel();
        gameStarted = false;
        _showDialog();
      }
      time += 0.01;
    });
  }

  int scoreBoard() {
    //must be updated if more barriers are added
    if (gameScore % 2 == 0) {
      if (barrierX[0] < -0.1) gameScore++;
    } else {
      if (barrierX[1] < -0.1) gameScore++;
    }

    return gameScore;
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                "GAME OVER",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            content: Container(
              height: 50,
              child: Column(
                children: [
                  Text(
                    "SCORE: " + scoreBoard().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "BEST: " + highScore.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                    child: Text(
                      "PLAY AGAIN",
                      style: TextStyle(color: Colors.brown),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameStarted = false;
      time = 0;
      initialHeight = birdYaxis;
      barrierX[0] = 1.7;
      barrierX[1] = barrierX[0] + 1.7;
      gameScore = 0;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.05;
      });
      if (barrierX[i] < -1.7) {
        barrierX[i] += 3.4;
      }
    }
  }

  /*bool birdIsDead() {
    if ((birdYaxis < -1.1 || birdYaxis > 1)) {
      if (gameScore > highScore) {
        highScore = gameScore;
      }
      return true;
    }
    return false;
  }*/

  bool birdIsDead() {
    if ((birdYaxis < -1.1 || birdYaxis > 1)) {
      if (gameScore > highScore) {
        highScore = gameScore;
      }
      return true;
    }
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= birdWidth &&
          (birdYaxis <= -1 + barrierHeight[i][0] ||
              birdYaxis + birdHeight >= 1 - barrierHeight[i][1])) {
        if (gameScore > highScore) {
          highScore = gameScore;
        }
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gameStarted ? jump() : startGame();
      },
      child: Scaffold(
        body: Column(
          children: (<Widget>[
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(
                      birdYaxis: birdYaxis,
                      birdWidth: birdWidth,
                      birdHeight: birdHeight,
                    ),
                  ),
                  /*AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 200.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 150.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 250.0,
                    ),
                  ),*/
                  //Add New Barrier Here
                  //Top Barrier 1
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierY: 1.1,
                    barrierHeight: 200.0,
                    isThisBottomBarrier: false,
                  ),
                  //Bottom Barrier 1
                  MyBarrier(
                    barrierX: barrierX[0],
                    barrierY: -1.1,
                    barrierHeight: 200.0,
                    isThisBottomBarrier: false,
                  ),
                  //Top Barrier 2
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierY: 1.1,
                    barrierHeight: 150.0,
                    isThisBottomBarrier: false,
                  ),
                  //Bottom Barrier 2
                  MyBarrier(
                    barrierX: barrierX[1],
                    barrierY: -1.1,
                    barrierHeight: 250.0,
                    isThisBottomBarrier: false,
                  ),
                  Container(
                      alignment: Alignment(0, -0.8),
                      child: gameStarted
                          ? Text(scoreBoard().toString(),
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 70,
                                color: Colors.white,
                              ))
                          : Text("T A P   T O   P L A Y",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ))),
                ],
              ),
            ),
            Container(
              height: 17,
              color: Colors.green.shade700,
            ),
            Expanded(
              child: Container(color: Colors.brown
                  /*child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SCORE",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text("0",
                            style: TextStyle(color: Colors.white, fontSize: 35))
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("BEST",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        SizedBox(
                          height: 20,
                        ),
                        Text("10",
                            style:
                                TextStyle(color: Colors.white, fontSize: 35)),
                      ],
                    ),
                  ],
                ),*/
                  ),
            ),
          ]),
        ),
      ),
    );
  }
}
