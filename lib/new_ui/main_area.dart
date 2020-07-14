import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/filter_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/item.dart';

class MainArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.amber,
        // TODO: Add some kind of NavigationBloc.
        child: _StashView());
  }
}

class _StashView extends StatelessWidget {
  const _StashView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StashBloc, StashState>(builder: (context, state) {
      if (state is StashLoadInProgress) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is StashLoadSuccess) {
        return MultiBlocProvider(providers: [
          BlocProvider<TabBloc>(
              create: (context) => TabBloc(stash: state.stash)),
          BlocProvider<FilterBloc>(
              create: (context) => FilterBloc(allItems: state.stash.allItems))
        ], child: _TabView());
      }
      if (state is StashLoadFailure) {
        return Center(child: Text('Stash load FAILED!'));
      }

      // default case
      return Center(
        child: Text(
          'Something went wrong, no state in StashView!',
          style: TextStyle(color: Colors.red),
        ),
      );
    });
  }
}

class _TabView extends StatelessWidget {
  const _TabView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<FilterBloc, FilterState>(
      listener: (context, state) {
        if (state is FilterSuccess) {
          BlocProvider.of<TabBloc>(context).add(CustomTabRequested(
              items: state.filterResult, tabName: 'Filtered Results'));
        }
      },
      child: BlocBuilder<TabBloc, TabState>(builder: (context, state) {
        if (state is TabInitial) {
          BlocProvider.of<FilterBloc>(context)
              .add(FilterRequested(filterType: FilterType.MOST_EXPENSIVE));

          return Center(child: CircularProgressIndicator());
        }
        if (state is TabUpdated) {
          return _ItemList(items: state.stashTab.items);
        }

        // default case
        return Center(
          child: Text(
            'Something went wrong, no state in ItemList!',
            style: TextStyle(color: Colors.red),
          ),
        );
      }),
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList({this.items}) : assert(items != null);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Text(items[index].typeLine);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: items.length);
  }
}
