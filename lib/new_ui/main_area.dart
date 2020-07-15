import 'package:cached_network_image/cached_network_image.dart';
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
    final Text name = Text('${item.typeLine}', overflow: TextOverflow.ellipsis);
    final Text tab = Text(
      '${item.stashName}',
      overflow: TextOverflow.ellipsis,
    );
    final Text links =
        item.socketLinks != 0 ? Text('${item.socketLinks}') : Text('N/A');
    final Text level = Text('${item.level ?? 'N/A'}');
    final Text quantity = Text('${item.stackSize ?? '1'}');
    final Text price = isPriced ? Text('${item.value.round()}') : Text('N/A');
    final Text totalValue =
        isPriced ? Text('${item.totalValue.round()}') : Text('N/A');

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
