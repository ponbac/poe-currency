import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Center(
          child: Text(
            'UNDER CONSTRUCTION',
            style: TextStyle(fontSize: 50),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
