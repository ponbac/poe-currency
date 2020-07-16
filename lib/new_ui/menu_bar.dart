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
          Expanded(flex: 7, child: _NavigationList()),
          Expanded(flex: 1, child: _LogOutButton())
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
            navPage: NavPage.STASH,
            onLinkPressed: () => BlocProvider.of<NavigationBloc>(context)
                .add(PageRequested(page: NavPage.STASH)),
            isActive: currentPage == NavPage.STASH ? true : false,
          ),
          _NavigationListLink(
            navPage: NavPage.CHARACTER,
            onLinkPressed: () =>
                print('NAVIGATION LIST LINK TO BE IMPLEMENTED!'),
            isActive: currentPage == NavPage.CHARACTER ? true : false,
          ),
          _NavigationListLink(
            navPage: NavPage.SETTINGS,
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
      {@required this.navPage,
      @required this.onLinkPressed,
      @required this.isActive})
      : assert(navPage != null),
        assert(onLinkPressed != null),
        assert(isActive != null);

  final NavPage navPage;
  final Function onLinkPressed;
  final bool isActive;

  final TextStyle textStyle = const TextStyle(
    color: Colors.grey,
    fontSize: 26,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w500,
  );

  // TODO: UGLY! REMAKE!
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLinkPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 12, left: 20),
        child: BlocBuilder<NavigationBloc, NavPage>(
          builder: (context, state) {
            if (navPage == NavPage.STASH) {
              return Text('Stash',
                  overflow: TextOverflow.ellipsis,
                  style: state == NavPage.STASH
                      ? textStyle.copyWith(color: kTextColor)
                      : textStyle.copyWith(color: Colors.grey[600]));
            }
            if (navPage == NavPage.CHARACTER) {
              return Text('Character',
                  overflow: TextOverflow.ellipsis,
                  style: state == NavPage.CHARACTER
                      ? textStyle.copyWith(color: kTextColor)
                      : textStyle.copyWith(color: Colors.grey[600]));
            }
            if (navPage == NavPage.SETTINGS) {
              return Text('Settings',
                  overflow: TextOverflow.ellipsis,
                  style: state == NavPage.SETTINGS
                      ? textStyle.copyWith(color: kTextColor)
                      : textStyle.copyWith(color: Colors.grey[600]));
            }

            return Text('NO WORKING BUTTON STATE!');
          },
        ),
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.exit_to_app,
          color: kTextColor,
        ),
        onPressed: () => BlocProvider.of<NavigationBloc>(context)
            .add(PageRequested(page: NavPage.LOGIN)));
  }
}
