import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/navigation_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/nav_page.dart';
import 'package:poe_currency/secrets.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _UserInformation(
              userName: poeAccountName,
              characterClass: 'Weird dude',
              avatarPath: 'assets/images/test-avatar.png',
            ),
          ),
          Spacer(),
          Expanded(flex: 7, child: _NavigationList())
        ],
      ),
    );
  }
}

class _UserInformation extends StatelessWidget {
  const _UserInformation(
      {@required this.userName,
      @required this.characterClass,
      @required this.avatarPath})
      : assert(userName != null),
        assert(characterClass != null),
        assert(avatarPath != null);

  final String userName;
  final String characterClass;
  final String avatarPath;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 25, left: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image(
            height: 70,
            width: 70,
            fit: BoxFit.cover,
            image: AssetImage(avatarPath),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10, left: 20),
        child: Text(
          userName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500,
              color: kTextColor),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20),
        child: Text(
          characterClass,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
      ),
    ]);
  }
}

// TODO: Fix highlighting of selected link!
class _NavigationList extends StatelessWidget {
  const _NavigationList();

  static const menuItems = ['Stash', 'Character', 'Settings'];

  @override
  Widget build(BuildContext context) {
    NavPage currentPage;

    return BlocListener<NavigationBloc, NavPage>(
      listener: (context, state) {
        currentPage = state;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NavigationListLink(
            linkText: menuItems[0],
            onLinkPressed: () => BlocProvider.of<NavigationBloc>(context)
                .add(PageRequested(page: NavPage.STASH)),
            isActive: currentPage == NavPage.STASH ? true : false,
          ),
          _NavigationListLink(
            linkText: menuItems[1],
            onLinkPressed: () =>
                print('NAVIGATION LIST LINK TO BE IMPLEMENTED!'),
            isActive: currentPage == NavPage.CHARACTER ? true : false,
          ),
          _NavigationListLink(
            linkText: menuItems[2],
            onLinkPressed: () =>
                print('NAVIGATION LIST LINK TO BE IMPLEMENTED!'),
            isActive: currentPage == NavPage.SETTINGS ? true : false,
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
    return GestureDetector(
      onTap: onLinkPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 12, left: 20),
        child: Text(
          linkText,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isActive ? kTextColor : Colors.grey[600],
            fontSize: 26,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
