import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poe_currency/models/item.dart';

class DetailedItemViewScreen extends StatelessWidget {
  final Item item;

  DetailedItemViewScreen({@required this.item}) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _upperInfo(),
            Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 150,
                width: 150,
                child: _itemImage()),
            Flexible(child: _modsBuilder()),
            Text('${item.descrText ?? ''}'),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                  child: Text('Back to stash'),
                  onPressed: () => Navigator.pop(context)),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemImage() {
    return FittedBox(
      child: CachedNetworkImage(
        imageUrl: item.icon,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      fit: BoxFit.fitHeight,
    );
  }

  Widget _modsBuilder() {
    List<String> allMods = new List<String>()
      ..addAll(item.implicitMods)
      ..addAll(item.explicitMods);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: allMods.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Text('${allMods[index]}', textAlign: TextAlign.center);
        });
  }

  Widget _upperInfo() {
    bool itemHasSockets = item.socketLinks != 0;

    if (itemHasSockets) {
      return Column(
        children: [
          Text(
            '${item.name ?? ''}',
            textAlign: TextAlign.center,
          ),
          Text('${item.typeLine ?? ''}', textAlign: TextAlign.center),
          Text('${item.socketLinks}-linked', textAlign: TextAlign.center),
          Row(
            children: [
              ListView.builder(
                  itemCount: item.sockets.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String socketColor = item.sockets[index].sColour;
                    String s;
                    Color c;

                    if (socketColor == 'R') {
                      s = 'R, ';
                      c = Colors.red;
                    } else if (socketColor == 'G') {
                      s = 'G, ';
                      c = Colors.green;
                    } else if (socketColor == 'B') {
                      s = 'B, ';
                      c = Colors.blue;
                    } else if (socketColor == 'W') {
                      s = 'W, ';
                      c = Colors.white;
                    } else {
                      s = 'S, ';
                      c = Colors.black;
                    }

                    // Remove trailing comma and space
                    /*if (index == item.sockets.length - 1) {
                      s = s.substring(-1, -3);
                    }*/

                    return Text(s,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: c));
                  })
            ],
          )
        ],
      );
    }

    return Column(
      children: [
        Text(
          '${item.name ?? ''}',
          textAlign: TextAlign.center,
        ),
        Text('${item.typeLine ?? ''}', textAlign: TextAlign.center),
      ],
    );
  }
}
