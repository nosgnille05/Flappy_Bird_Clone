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

  //Game Variables
  bool gameStarted = false;
  int gameScore = 0;
  int highScore = 0;

  //Barrier Variables
  static double barrierXone = 1.7;
  static double barrierXtwo = barrierXone + 1.7;

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

      setState(() {
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
      });

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
      if (barrierXone < -0.1) gameScore++;
    } else {
      if (barrierXtwo < -0.1) gameScore++;
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
                    "Your score: " + scoreBoard().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "High score: " + highScore.toString(),
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
      barrierXone = 1.7;
      barrierXtwo = barrierXone + 1.7;
      gameScore = 0;
    });
  }

  bool birdIsDead() {
    if (birdYaxis < -1.1 || birdYaxis > 1) {
      if (gameScore > highScore) {
        highScore = gameScore;
      }
      return true;
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
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: MyBird(),
                  ),
                  Container(
                      alignment: Alignment(0, -0.2),
                      child: gameStarted
                          ? Text(scoreBoard().toString(),
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                              ))
                          : Text("T A P   T O   P L A Y",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ))),
                  AnimatedContainer(
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
                  ),
                  /*AnimatedContainer(
                    alignment: Alignment(barrierXthree, 1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 300.0,
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXthree, -1.1),
                    duration: Duration(milliseconds: 0),
                    child: MyBarrier(
                      size: 100.0,
                    ),
                  ),*/
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
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
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
