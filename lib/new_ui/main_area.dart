import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/navigation_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/nav_page.dart';
import 'package:poe_currency/new_ui/login_view.dart';
import 'package:poe_currency/new_ui/stash_view.dart';


// TODO: REMOVE THIS CLASS AND DO EVERYTHING IN START!
class MainArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kBackgroundColor,
        child: BlocBuilder<NavigationBloc, NavPage>(
          builder: (context, state) {
            if (state == NavPage.LOGIN) {
              return LoginView();
            }
            if (state == NavPage.STASH) {
              return StashView();
            }

            return Text('NO VALID NAV STATE!');
          },
        ));
  }
}
