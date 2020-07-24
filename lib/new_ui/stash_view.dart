import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/filter_bloc.dart';
import 'package:poe_currency/bloc/pricing_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/models/user.dart';
import 'package:poe_currency/new_ui/top_bar.dart';

import '../constants.dart';

class StashView extends StatelessWidget {
  final User currentUser;

  const StashView({@required this.currentUser}) : assert(currentUser != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StashBloc, StashState>(builder: (context, state) {
      if (state is StashInitial) {
        return Text('Grabbing stash...');
      }
      if (state is StashLoadInProgress) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(15),
                  child: CircularProgressIndicator()),
              Text('Fetching your stash...')
            ],
          ),
        );
      }
      if (state is StashLoadSuccess) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                  create: (context) => TabBloc(stash: state.stash)),
              BlocProvider<FilterBloc>(
                  create: (context) => FilterBloc(
                      allItems: state.stash.allItems,
                      pricingBloc: BlocProvider.of<PricingBloc>(context)))
            ],
            child: BlocBuilder<PricingBloc, PricingState>(
                builder: (context, state) {
              if (state is PricingInitial || state is PricingInProgress) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: CircularProgressIndicator()),
                      Text('Fetching pricing data...')
                    ],
                  ),
                );
              }

              // When done pricing items or pricing failed
              return Column(
                children: [
                  Expanded(flex: 1, child: TopBar()),
                  Expanded(flex: 5, child: _TabView()),
                ],
              );
            }));
      }
      if (state is StashLoadFailure) {
        return Center(child: Text('Stash load FAILED!\n${state.errorMessage}'));
      }

      // default case
      return Center(
        child: Text(
          'Something went wrong, no state in StashView! State = ${state.toString()}',
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
              items: state.filterResult,
              tabName:
                  'Items')); // TODO: Should this be done in the BLOC with a listener?
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

      return Column(
        children: [
          Expanded(
            flex: 1,
            child: _ItemListHeader(),
          ),
          Expanded(
            flex: 10,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return _ItemListItem(item: items[index], isPriced: isPriced);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: items.length),
          ),
        ],
      );
    });
  }
}

class _ItemListHeader extends StatelessWidget {
  const _ItemListHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 2,
            child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child: Text('Tabs', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child:
                Text('Links', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child:
                Text('Level', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child: Text('Quantity',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child:
                Text('Price', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child: Text('Total value',
                style: TextStyle(fontWeight: FontWeight.bold)))
      ],
    );
  }
}

class _ItemListItem extends StatelessWidget {
  const _ItemListItem({@required this.item, this.isPriced = false})
      : assert(item != null);

  final Item item;
  final bool isPriced;

  @override
  Widget build(BuildContext context) {
    final Text name = Text('${item.typeLine}',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: kPrimaryColor));
    final Text tab = Text(
      '${item.tabs.toString().replaceFirst('[', '').replaceFirst(']', '')}',
      overflow: TextOverflow.ellipsis,
    );
    final Text links =
        item.socketLinks != 0 ? Text('${item.socketLinks}') : Text('N/A');
    final Text level = Text('${item.level ?? 'N/A'}');
    final Text quantity = Text('${item.stackSize ?? '1'}');
    final Text price = isPriced
        ? Text('${double.parse((item.value).toStringAsFixed(2))}',
            style: TextStyle(color: kPrimaryColor))
        : Text('N/A');
    final Text totalValue = isPriced
        ? Text('${double.parse((item.totalValue).toStringAsFixed(2))}',
            style: TextStyle(color: kPrimaryColor))
        : Text('N/A');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _ItemIcon(iconUrl: item.icon)),
        Expanded(flex: 2, child: name),
        Expanded(flex: 1, child: tab),
        Expanded(flex: 1, child: links),
        Expanded(flex: 1, child: level),
        Expanded(flex: 1, child: quantity),
        Expanded(flex: 1, child: price),
        Expanded(flex: 1, child: totalValue)
      ],
    );
  }
}

class _ItemIcon extends StatelessWidget {
  const _ItemIcon({@required this.iconUrl}) : assert(iconUrl != null);

  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: CachedNetworkImage(
        imageUrl: iconUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
