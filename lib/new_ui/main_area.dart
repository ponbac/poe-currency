import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/login_bloc.dart';
import 'package:poe_currency/bloc/navigation_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/nav_page.dart';
import 'package:poe_currency/models/user.dart';
import 'package:poe_currency/new_ui/login_view.dart';
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
              sessionId: user.poeSessionId, accountName: user.accountname));

          return StashView(currentUser: user);
        }
        if (state is LoginInitial || state is LoginFailure) {
          return LoginView();
        }
        if (state is LoginInProgress) {
          return Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
