import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/search_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/models/stash_tab.dart';
import 'package:poe_currency/screens/detailed_item_view_screen.dart';
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
              decoration: InputDecoration(hintText: 'search something'),
              onChanged: (text) => BlocProvider.of<SearchBloc>(context)
                  .add(SearchRequested(searchString: searchController.text)),
            ),
          ),
          SizedBox(
            height: 30,
            width: 60,
            child: RaisedButton(
                child: Text('GO!'),
                onPressed: () => BlocProvider.of<SearchBloc>(context)
                    .add(SearchRequested(searchString: searchController.text))),
          )
        ],
      ),
    );
  }

  Widget _tab(
      BuildContext context, StashTab stashTab, Orientation orientation) {
    String tabName = stashTab.name;
    String tabType = stashTab.type ?? 'Custom';
    int tabIndex = stashTab.index ?? -1;
    List<Item> items = stashTab.items;

    return Expanded(
      child: Column(
        children: [
          _topButtons(context, tabIndex, tabName),
          Text(
            '$tabType\nItems displayed = ${items.length}',
            textAlign: TextAlign.center,
          ),
          _itemBox(context, items, orientation)
        ],
      ),
    );
  }

  Widget _topButtons(BuildContext context, int tabIndex, String tabName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
            child: Text('PREV'),
            color: Colors.amber,
            onPressed: () => BlocProvider.of<TabBloc>(context)
                .add(TabPrevious(currentTabIndex: tabIndex))),
        Text(
          '$tabName',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        RaisedButton(
            child: Text('NEXT'),
            color: Colors.amber,
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
    print('Width: $screenWidth');

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

  /*Widget _oldItemCard(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailedItemViewScreen(
                item: item,
              ))),
      child: new Card(
        child: new GridTile(
          footer: new Text(
            '${item.typeLine}${item.stackSize == null ? '' : ',\nStack size: ' + item.stackSize.toString()}',
            textAlign: TextAlign.center,
          ),
          child: CachedNetworkImage(
            imageUrl: item.icon,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    value: downloadProgress.progress),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }*/
}
