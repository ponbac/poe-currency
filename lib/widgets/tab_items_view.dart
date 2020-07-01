import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/models/stash.dart';

class TabItemsView extends StatelessWidget {
  static const int INITIAL_TAB_INDEX = 0;

  final Stash stash;

  TabItemsView({@required this.stash});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return BlocBuilder<TabBloc, TabState>(builder: (context, state) {
      if (state is TabInitial) {
        String tabName = stash.tabs[INITIAL_TAB_INDEX].name;
        List<Item> items = stash.tabs[INITIAL_TAB_INDEX].items;

        return Column(
          children: [
            _topButtons(context, INITIAL_TAB_INDEX, tabName),
            Text('Items in tab = ${items.length}'),
            Card(
            child: new GridTile(
              footer: new Text('${items[0].typeLine}, ${items[0].stackSize}'),
              child: CachedNetworkImage(
                imageUrl: 'https://poe-currency-ad0db.web.app/icons/Icon-512.png',
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
            //_itemBox(items, orientation)
          ],
        );
      }
      if (state is TabUpdated) {
        int tabIndex = state.tabIndex;
        String tabName = stash.tabs[tabIndex].name;
        List<Item> items = stash.tabs[tabIndex].items;

        return Column(
          children: [
            _topButtons(context, tabIndex, tabName),
            Text('Items in tab = ${items.length}'),
            _itemBox(items, orientation)
          ],
        );
      }

      return Text('NO STATE');
    });
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
}

Widget _itemBox(List<Item> items, Orientation screenOrientation) {
  return Expanded(
    child: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (screenOrientation == Orientation.portrait) ? 3 : 6),
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return new Card(
            child: new GridTile(
              footer: new Text('${item.typeLine}, ${item.stackSize}'),
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
          );
        }),
  );
}
