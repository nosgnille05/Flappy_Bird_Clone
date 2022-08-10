import 'package:flappy_bird_clone/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: (<Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: Center(child: MyBird()),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ]),
      ),
    );
  }
}
