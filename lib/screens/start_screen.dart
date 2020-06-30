import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/secrets.dart';

import 'package:cached_network_image/cached_network_image.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

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
              final items = state.items;

              return Expanded(
                child: Column(
                  children: [
                    _topButtons(context, state),
                    Expanded(
                      child: GridView.builder(
                          itemCount: items.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 3
                                          : 6),
                          itemBuilder: (BuildContext context, int index) {
                            final item = items[index];

                            return new Card(
                              child: new GridTile(
                                footer: new Text(
                                    '${item.typeLine}, ${item.stackSize}'),
                                child: CachedNetworkImage(
                                  imageUrl: item.icon,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
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

  Widget _topButtons(BuildContext context, StashLoadSuccess state) {
    int stashIndex = state.stashIndex;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
            child: Text('Previous'),
            color: Colors.amber,
            onPressed: () => BlocProvider.of<StashBloc>(context).add(
                StashRequested(
                    sessionId: POE_SESSION_ID,
                    accountName: POE_ACCOUNT_NAME,
                    stashIndex: stashIndex == 0 || stashIndex == 2
                        ? 0
                        : stashIndex - 1))),
        RaisedButton(
            child: Text('Next'),
            color: Colors.amber,
            onPressed: () => BlocProvider.of<StashBloc>(context).add(
                StashRequested(
                    sessionId: POE_SESSION_ID,
                    accountName: POE_ACCOUNT_NAME,
                    stashIndex: stashIndex == 0 ? 2 : stashIndex + 1)))
      ],
    );
  }
}
