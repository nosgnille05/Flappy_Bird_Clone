// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
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
  int gameCount = 0;
  bool levelOneMedal = false;
  bool levelTwoMedal = false;
  bool levelThreeMedal = false;
  bool levelFourMedal = false;
  bool levelFiveMedal = false;
  bool levelSixMedal = false;
  int firstBestRun = 0;
  int secondBestRun = 0;
  int thirdBestRun = 0;

  //Barrier Variables
  static List<double> barrierX = [1.7, 1.7 + 1.7];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];
  static List<double> barrierWid = [75.0, 100.0];

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameCount++;
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + velocity * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });

      //Update Barrier Position
      moveMap();

      //Game Over Display Output of Game
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
      if (barrierX[0] < -0.15) gameScore++;
    } else {
      if (barrierX[1] < -0.15) gameScore++;
    }

    return gameScore;
  }

  int first() {
    if (scoreBoard() > firstBestRun) {
      if (firstBestRun > 0) {
        //knocking off champion
        secondBestRun = firstBestRun;
      }
      firstBestRun = scoreBoard();
      return firstBestRun;
    }
    return firstBestRun;
  }

  int second() {
    if (scoreBoard() > secondBestRun && scoreBoard() < first()) {
      if (secondBestRun > 0) {
        //knocking off champion
        thirdBestRun = secondBestRun;
      }
      secondBestRun = scoreBoard();
      return secondBestRun;
    }
    return secondBestRun;
  }

  int third() {
    if (scoreBoard() > thirdBestRun && scoreBoard() < second()) {
      thirdBestRun = scoreBoard();
      return thirdBestRun;
    }
    return thirdBestRun;
  }

  String firstPlaceMedalWon() {
    if (first() == 0) {
      return 'lib/images/no_new_medal.png';
    } else if (first() < 6) {
      return 'lib/images/red_medal.png';
    } else if (first() < 16) {
      return 'lib/images/blue_medal.png';
    } else if (first() < 36) {
      return 'lib/images/green_medal.png';
    } else if (first() < 51) {
      return 'lib/images/indigo_medal.png';
    } else if (first() < 101) {
      return 'lib/images/pink_medal.png';
    }
    return 'lib/images/flappy_bird.png';
  }

  String secondPlaceMedalWon() {
    if (second() == 0) {
      return 'lib/images/no_new_medal.png';
    } else if (second() < 6) {
      return 'lib/images/red_medal.png';
    } else if (second() < 16) {
      return 'lib/images/blue_medal.png';
    } else if (second() < 36) {
      return 'lib/images/green_medal.png';
    } else if (second() < 51) {
      return 'lib/images/indigo_medal.png';
    } else if (second() < 101) {
      return 'lib/images/pink_medal.png';
    }
    return 'lib/images/flappy_bird.png';
  }

  String thirdPlaceMedalWon() {
    if (third() == 0) {
      return 'lib/images/no_new_medal.png';
    } else if (third() < 6) {
      return 'lib/images/red_medal.png';
    } else if (third() < 16) {
      return 'lib/images/blue_medal.png';
    } else if (third() < 36) {
      return 'lib/images/green_medal.png';
    } else if (third() < 51) {
      return 'lib/images/indigo_medal.png';
    } else if (third() < 101) {
      return 'lib/images/pink_medal.png';
    }
    return 'lib/images/flappy_bird.png';
  }

  void _showLeaderDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.transparent,
            content: Column(
              children: [
                Container(
                  width: 400,
                  height: 210,
                  margin: EdgeInsets.only(bottom: 45, top: 115),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.brown.shade200,
                  ),
                  child: Column(children: [
                    Container(
                      child: Text(
                        'LEADERS',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5, left: 20),
                      child: Row(
                        children: [
                          Text('Rank   Medal   Score',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, left: 40),
                      child: Row(
                        children: [
                          Text('1.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Image.asset(firstPlaceMedalWon(),
                                width: 35, height: 35),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(first().toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, left: 40),
                      child: Row(
                        children: [
                          Text('2.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Image.asset(secondPlaceMedalWon(),
                                width: 35, height: 35),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(second().toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      child: Row(
                        children: [
                          Text('3.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Image.asset(thirdPlaceMedalWon(),
                                width: 35, height: 35),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            child: Text(third().toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25)),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Container(
                  alignment: Alignment(-0.9, 0.8),
                  child: GestureDetector(
                    onTap: resetGame,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 400,
                        height: 75,
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.brown.shade200,
                        ),
                        child: Text(
                          "B A C K",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  //6, 16, 36, 51, 101
  String medalWon() {
    if (scoreBoard() == 0) {
      return 'lib/images/flappy_bird.png';
    } else if (scoreBoard() < 6) {
      return 'lib/images/red_medal.png';
    } else if (scoreBoard() < 16) {
      return 'lib/images/blue_medal.png';
    } else if (scoreBoard() < 36) {
      return 'lib/images/green_medal.png';
    } else if (scoreBoard() < 51) {
      return 'lib/images/indigo_medal.png';
    } else if (scoreBoard() < 101) {
      return 'lib/images/pink_medal.png';
    }
    return 'lib/images/flappy_bird.png';
  }

  String newMedal() {
    if (scoreBoard() == 0) {
      if (levelOneMedal == false) {
        levelOneMedal = true;
        return 'lib/images/new_medal.png';
      }
    } else if (scoreBoard() < 6) {
      if (levelTwoMedal == false) {
        levelTwoMedal = true;
        return 'lib/images/new_medal.png';
      }
    } else if (scoreBoard() < 16) {
      if (levelThreeMedal == false) {
        levelThreeMedal = true;
        return 'lib/images/new_medal.png';
      }
    } else if (scoreBoard() < 36) {
      if (levelFourMedal == false) {
        levelFourMedal = true;
        return 'lib/images/new_medal.png';
      }
    } else if (scoreBoard() < 51) {
      if (levelFiveMedal == false) {
        levelFiveMedal = true;
        return 'lib/images/new_medal.png';
      }
    } else if (scoreBoard() < 101) {
      if (levelSixMedal == false) {
        levelSixMedal = true;
        return 'lib/images/new_medal.png';
      }
    }
    return 'lib/images/no_new_medal.png';
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.transparent,
            content: Column(
              children: [
                Container(
                  width: 400,
                  height: 85,
                  margin: EdgeInsets.only(bottom: 15, top: 100),
                  alignment: Alignment.center,
                  child: Image.asset('lib/images/game_over.png',
                      width: 400, height: 85),
                ),
                Container(
                  width: 400,
                  height: 125,
                  margin: EdgeInsets.only(bottom: 45),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.brown.shade200),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 115,
                        height: 115,
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 11),
                              child: Text(
                                "MEDAL:",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 0, top: 0),
                                  alignment: Alignment.topLeft,
                                  width: 50,
                                  height: 15,
                                  child: Image.asset(
                                    newMedal(),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0),
                              alignment: Alignment.topCenter,
                              width: 50,
                              height: 50,
                              child: Image.asset(medalWon(),
                                  width: 50, height: 50),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 115,
                        height: 115,
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            Text(
                              "SCORE: ",
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              scoreBoard().toString() + "\n",
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "BEST: ",
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              highScore.toString(),
                              textAlign: TextAlign.right,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 75,
                      margin: EdgeInsets.only(right: 64),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: resetGame,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            alignment: Alignment(-0.9, 0.8),
                            child: Container(
                              width: 100,
                              height: 75,
                              padding: EdgeInsets.all(8),
                              color: Colors.brown.shade200,
                              child: Text(
                                "PLAY\nAGAIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 75,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: _showLeaderDialog,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            alignment: Alignment(-0.9, 0.8),
                            child: Container(
                              width: 100,
                              height: 75,
                              padding: EdgeInsets.all(8),
                              color: Colors.brown.shade200,
                              child: Text(
                                "Leader\nBoard",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                    color: Colors.blue.shade400,
                    child: MyBird(
                      birdYaxis: birdYaxis,
                      birdWidth: birdWidth,
                      birdHeight: birdHeight,
                    ),
                  ),
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
                      alignment: Alignment(0, -0.75),
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
              color: Colors.green.shade400,
            ),
            Expanded(
              child: Container(color: Colors.orange.shade100),
            ),
          ]),
        ),
      ),
    );
  }
}
