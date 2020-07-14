import 'package:flutter/material.dart';
import 'package:poe_currency/constants.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        children: [_UserInformation(), Spacer(), _NavigationList()],
      ),
    );
  }
}

class _UserInformation extends StatelessWidget {
  const _UserInformation();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(children: [
        Text('INFO!')
      ]),
    );
  }
}

class _NavigationList extends StatelessWidget {
  const _NavigationList();

  static const menuItems = ['Stash', 'Character', 'Settings'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NavigationListLink(
            linkText: menuItems[0],
            onLinkPressed: () =>
                print('NAVIGATION LIST LINK TO BE IMPLEMENTED!'),
            isActive: false,
          ),
          _NavigationListLink(
            linkText: menuItems[1],
            onLinkPressed: () =>
                print('NAVIGATION LIST LINK TO BE IMPLEMENTED!'),
            isActive: false,
          ),
          _NavigationListLink(
            linkText: menuItems[2],
            onLinkPressed: () =>
                print('NAVIGATION LIST LINK TO BE IMPLEMENTED!'),
            isActive: false,
          )
        ],
      ),
    );
  }
}

class _NavigationListLink extends StatelessWidget {
  const _NavigationListLink(
      {@required this.linkText,
      @required this.onLinkPressed,
      @required this.isActive})
      : assert(linkText != null),
        assert(onLinkPressed != null),
        assert(isActive != null);

  final String linkText;
  final Function onLinkPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Text(
        linkText,
        style: TextStyle(
            color: isActive ? kTextColor : Colors.grey[600],
            fontSize: 30,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,),
      ),
    );
  }
}
