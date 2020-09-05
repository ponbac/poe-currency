import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/login/login_bloc.dart';
import 'package:poe_currency/bloc/navigation/navigation_bloc.dart';
import 'package:poe_currency/bloc/stash/stash_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/nav_page.dart';
import 'package:poe_currency/models/user/user.dart';
import 'package:poe_currency/new_ui/friends_view.dart';
import 'package:poe_currency/new_ui/login_view.dart';
import 'package:poe_currency/new_ui/menu_bar.dart';
import 'package:poe_currency/new_ui/stash_view.dart';

// TODO: REMOVE THIS CLASS AND DO EVERYTHING IN START!
class MainArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginSuccess) {
          User user = state.user;

          BlocProvider.of<StashBloc>(context).add(StashRequested(
              username: user.username,
              sessionId: user.poeSessionId,
              accountName: user.accountname));
          BlocProvider.of<NavigationBloc>(context)
              .add(PageRequested(page: NavPage.STASH));

          return Row(
            children: [
              Expanded(child: MenuBar()),
              BlocBuilder<NavigationBloc, NavPage>(
                builder: (context, state) {
                  if (state == NavPage.STASH) {
                    return Expanded(
                        flex: 5, child: StashView());
                  }
                  if (state == NavPage.FRIENDS) {
                    return Expanded(
                        flex: 5, child: FriendsView());
                  }

                  return Text('Not implemented state: $state');
                },
              )
            ],
          );
        }
        if (state is LoginInProgress) {
          return Center(child: CircularProgressIndicator());
        }

        return LoginView();
      }),
    );
  }
}
