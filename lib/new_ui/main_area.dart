import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/constants.dart';

class MainArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: BlocBuilder<StashBloc, StashState>(builder: (context, state) {
                if (state is StashInitial) {
                  // TODO: Figure out the blocks!
                }
                
                // default case
                return Center(
                  child: Text(
                    'Something went wrong, no state!',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }),
    );
  }
}