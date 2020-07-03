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
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 150,
              width: 150,
              child: FittedBox(
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
                fit: BoxFit.fitHeight,
              ),
            ),
            Text('${item.explicitMods[0]}\n${item.descrText}', textAlign: TextAlign.center,),
            Container(
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
}
