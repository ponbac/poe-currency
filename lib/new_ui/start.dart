import 'package:flutter/material.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/new_ui/main_area.dart';
import 'package:poe_currency/new_ui/menu_bar.dart';
import 'package:poe_currency/new_ui/top_bar.dart';

// Inspiration: https://dribbble.com/shots/11663910--Exploration-Bookmark-App
//              https://www.youtube.com/watch?v=E6fLm5XlJDY
//              https://github.com/abuanwar072/Protfolio-Website-Flutter-Web

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Row(
        children: [
          Expanded(flex: 1, child: MenuBar()),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(flex: 1, child: TopBar()),
                Expanded(flex: 4, child: MainArea())
              ],
            ),
          )
        ],
      ),
    );
  }
}
