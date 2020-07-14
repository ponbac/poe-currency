import 'package:flutter/material.dart';
import 'package:poe_currency/constants.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Expanded(
            flex: 8,
            child: _Title(
              titleText: 'Stash',
            ),
          ),
          Expanded(flex: 2, child: _SearchField()),
          Spacer()
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({@required this.titleText}) : assert(titleText != null);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: TextStyle(
        color: kTextColor,
        fontSize: 40,
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: kTextColor, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          hintStyle: TextStyle(
            color: kTextColor.withOpacity(0.5),
            fontSize: 14,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400,
          ),
          hintText: 'Enter a search term...',
        ),
        style: TextStyle(
          color: kTextColor,
          fontSize: 14,
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
