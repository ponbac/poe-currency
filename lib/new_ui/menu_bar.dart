import 'package:flutter/material.dart';
import 'package:poe_currency/constants.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kThirdColor,
      child: Column(
        children: [
          Text(
            'STASH',
            style: TextStyle(fontFamily: 'Naruto', fontSize: 40),
          )
        ],
      ),
    );
  }
}
