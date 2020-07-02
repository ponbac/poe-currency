import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/models/stash.dart';
import 'package:poe_currency/screens/detailed_item_view_screen.dart';

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
        String tabType = stash.tabs[INITIAL_TAB_INDEX].type;
        List<Item> items = stash.tabs[INITIAL_TAB_INDEX].items;

        return Expanded(
          child: Column(
            children: [
              _topButtons(context, INITIAL_TAB_INDEX, tabName),
              Text(
                '$tabType\nItems in tab = ${items.length}',
                textAlign: TextAlign.center,
              ),
              _itemBox(context, items, orientation)
            ],
          ),
        );
      }
      if (state is TabUpdated) {
        int tabIndex = state.tabIndex;
        String tabName = stash.tabs[tabIndex].name;
        String tabType = stash.tabs[tabIndex].type;
        List<Item> items = stash.tabs[tabIndex].items;

        return Expanded(
          child: Column(
            children: [
              _topButtons(context, tabIndex, tabName),
              Text(
                '$tabType\nItems in tab = ${items.length}',
                textAlign: TextAlign.center,
              ),
              _itemBox(context, items, orientation)
            ],
          ),
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

  Widget _itemBox(
      BuildContext context, List<Item> items, Orientation screenOrientation) {
    return Expanded(
      child: GridView.builder(
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (screenOrientation == Orientation.portrait) ? 3 : 6),
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];

            return _itemCard(context, item);
          }),
    );
  }

  Widget _itemCard(BuildContext context, Item item) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailedItemViewScreen(
                item: item,
              ))),
      child: new Card(
        child: new GridTile(
          footer: new Text('${item.typeLine}, ${item.stackSize}', textAlign: TextAlign.center,),
          child: CachedNetworkImage(
            imageUrl: item.icon,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
