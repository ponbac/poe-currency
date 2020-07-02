import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/secrets.dart';
import 'package:poe_currency/widgets/tab_items_view.dart';

class StartScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sessionIdController = TextEditingController();

  void _displayStash(BuildContext context) {
    poeAccountName = _nameController.text;
    poeSessionId = _sessionIdController.text;

    BlocProvider.of<StashBloc>(context).add(
        StashRequested(sessionId: poeSessionId, accountName: poeAccountName));
  }

  void _displayStashTesting(BuildContext context) {
    BlocProvider.of<StashBloc>(context).add(
        StashRequested(sessionId: poeSessionId, accountName: poeAccountName));
  }

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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                          controller: _nameController,
                          decoration:
                              InputDecoration(hintText: 'Account name')),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _sessionIdController,
                        decoration: InputDecoration(hintText: 'Session ID'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: RaisedButton(
                          child: Text('GO!'),
                          onPressed: () => _displayStash(context)),
                    ),
                    RaisedButton(
                        child: Text('testing'),
                        onPressed: () => _displayStashTesting(context))
                  ],
                ),
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
                child: Column(
                  children: [
                    Text(
                      'Something went wrong:\n${state.errorMessage}',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: RaisedButton(
                        child: Text('Go back'),
                          onPressed: () => BlocProvider.of<StashBloc>(context)
                              .add(StashReset())),
                    )
                  ],
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
