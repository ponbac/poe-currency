import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/pricing_bloc.dart';
import 'package:poe_currency/bloc/search_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/models/stash_tab.dart';
import 'package:poe_currency/widgets/item_card.dart';

class TabItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: _searchBox(context)),
          BlocBuilder<TabBloc, TabState>(builder: (context, state) {
            if (state is TabInitial) {
              return _tab(context, state.stashTab, orientation);
            }
            if (state is TabUpdated) {
              BlocProvider.of<PricingBloc>(context)
                  .add(PricingRequested(itemsToPrice: state.stashTab.items));
              return _tab(context, state.stashTab, orientation);
            }

            return Text('NO STATE');
          }),
        ],
      ),
    );
  }

  Widget _searchBox(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchSuccess) {
          BlocProvider.of<TabBloc>(context).add(CustomTabRequested(
              items: state.searchResult, tabName: 'Search results'));
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 160,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: 'search something...',
                  hintStyle: TextStyle(color: kPrimaryColor)),
              onChanged: (text) => BlocProvider.of<SearchBloc>(context)
                  .add(SearchRequested(searchString: searchController.text)),
            ),
          ),
          SizedBox(
            height: 30,
            width: 70,
            child: RaisedButton(
                child: Text('GO'),
                onPressed: () => BlocProvider.of<SearchBloc>(context)
                    .add(SearchRequested(searchString: searchController.text))),
          ),
        ],
      ),
    );
  }

  Widget _tab(
      BuildContext context, StashTab stashTab, Orientation orientation) {
    String tabType = stashTab.type ?? 'Custom';
    List<Item> items = stashTab.items;

    return Expanded(
      child: Column(
        children: [
          _topButtons(context, stashTab),
          Text(
            '$tabType\nItems displayed = ${items.length}',
            textAlign: TextAlign.center,
          ),
          _itemBox(context, items, orientation)
        ],
      ),
    );
  }

  Widget _topButtons(BuildContext context, StashTab stashTab) {
    String tabName = stashTab.name;
    int tabIndex = stashTab.index ?? -1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
            child: Text('PREV'),
            onPressed: () => BlocProvider.of<TabBloc>(context)
                .add(TabPrevious(currentTabIndex: tabIndex))),
        BlocBuilder<PricingBloc, PricingState>(
          builder: (context, state) {
            if (state is PricingSuccess) {
              return Text(
                '$tabName, ${stashTab.totalValue} chaos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }

            return Text(
              '$tabName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          },
        ),
        RaisedButton(
            child: Text('NEXT'),
            onPressed: () => BlocProvider.of<TabBloc>(context)
                .add(TabNext(currentTabIndex: tabIndex)))
      ],
    );
  }

  Widget _itemBox(
      BuildContext context, List<Item> items, Orientation screenOrientation) {
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _itemsPerRow(width)),
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];

            return ItemCard(item: item);
          }),
    );
  }

  int _itemsPerRow(double screenWidth) {
    //print('Width: $screenWidth');

    if (screenWidth < 360) {
      return 1;
    } else if (screenWidth < 500) {
      return 2;
    } else if (screenWidth < 600) {
      return 3;
    } else if (screenWidth < 800) {
      return 4;
    } else if (screenWidth < 1000) {
      return 5;
    } else if (screenWidth < 1200) {
      return 6;
    } else if (screenWidth < 1400) {
      return 7;
    } else if (screenWidth < 1600) {
      return 8;
    } else if (screenWidth < 1800) {
      return 9;
    }

    return 10;
  }
}
