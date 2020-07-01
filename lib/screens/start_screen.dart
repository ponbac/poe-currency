import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/secrets.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:poe_currency/widgets/tab_items_view.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          BlocBuilder<StashBloc, StashState>(builder: (context, state) {
            if (state is StashInitial) {
              return Column(
                children: [
                  RaisedButton(
                      child: Text('Grab data!'),
                      color: Colors.amber,
                      onPressed: () => BlocProvider.of<StashBloc>(context).add(
                          StashRequested(
                              sessionId: POE_SESSION_ID,
                              accountName: POE_ACCOUNT_NAME))),
                  Center(child: Text('Press button, plz')),
                ],
              );
            }
            if (state is StashLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is StashLoadSuccess) {
              Stash stash = state.stash;

              return BlocProvider(
                  create: (context) => TabBloc(numberOfTabs: stash.tabs.length),
                  child: TabItemsView(
                    stash: stash,
                  ));
            }
            if (state is StashLoadFailure) {
              return Center(
                child: Text(
                  'Something went wrong!\n${state.errorMessage}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }

            // default case
            return Center(
              child: Text(
                'Something went wrong, no state!',
                style: TextStyle(color: Colors.red),
              ),
            );
          }),
        ],
      ),
    );
  }
}
