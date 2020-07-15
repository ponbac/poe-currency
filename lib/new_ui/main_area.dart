import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/filter_bloc.dart';
import 'package:poe_currency/bloc/pricing_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/new_ui/top_bar.dart';

class MainArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: kBackgroundColor,
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
        return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                  create: (context) => TabBloc(stash: state.stash)),
              BlocProvider<FilterBloc>(
                  create: (context) =>
                      FilterBloc(allItems: state.stash.allItems))
            ],
            child: Column(
              children: [
                Expanded(flex: 1, child: TopBar()),
                Expanded(flex: 4, child: _TabView()),
              ],
            ));
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
          return _ItemList(items: state.stashTab.items);
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
    return BlocBuilder<PricingBloc, PricingState>(builder: (context, state) {
      bool isPriced = false;

      if (state is PricingSuccess) {
        isPriced = true;
      }

      return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return _ItemListItem(item: items[index], isPriced: isPriced);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          itemCount: items.length);
    });
  }
}

class _ItemListItem extends StatelessWidget {
  const _ItemListItem({@required this.item, this.isPriced = false})
      : assert(item != null);

  final Item item;
  final bool isPriced;

  @override
  Widget build(BuildContext context) {
    return isPriced
        ? Text('${item.typeLine}, ${item.totalValue.round()}C')
        : Text('${item.typeLine}');
  }
}
