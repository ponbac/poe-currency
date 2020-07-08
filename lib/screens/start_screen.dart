import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/filter_bloc.dart';
import 'package:poe_currency/bloc/pricing_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/repositories/pricing_repository.dart';
import 'package:poe_currency/secrets.dart';
import 'package:poe_currency/widgets/tab_items_view.dart';

import '../constants.dart';

class StartScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sessionIdController = TextEditingController();
  final PricingRepository pricingRepository;

  StartScreen({@required this.pricingRepository})
      : assert(pricingRepository != null);

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
    return BlocProvider<PricingBloc>(
      create: (context) => PricingBloc(
          pricingRepository: pricingRepository,
          stashBloc: BlocProvider.of<StashBloc>(context)),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/space.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
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
                              decoration: InputDecoration(
                                  hintText: 'Account name',
                                  hintStyle: TextStyle(color: kPrimaryColor))),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _sessionIdController,
                            decoration: InputDecoration(
                                hintText: 'Session ID',
                                hintStyle: TextStyle(color: kPrimaryColor)),
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
                  return MultiBlocProvider(providers: [
                    BlocProvider<TabBloc>(
                        create: (context) => TabBloc(stash: state.stash)),
                    BlocProvider<FilterBloc>(
                        create: (context) =>
                            FilterBloc(allItems: state.stash.allItems))
                  ], child: TabItemsView());
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
                              onPressed: () =>
                                  BlocProvider.of<StashBloc>(context)
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
        ),
      ),
    );
  }
}
