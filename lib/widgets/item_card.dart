import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poe_currency/models/item.dart';
import 'package:poe_currency/screens/detailed_item_view_screen.dart';

import '../constants.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key key, this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DetailedItemViewScreen(
                item: item,
              ))),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.5),
            border: Border.all(
                color: kThirdColor.withOpacity(0.5), width: 3.0),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        margin: EdgeInsets.only(
          left: kDefaultPadding / 2.5,
          right: kDefaultPadding / 2.5,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            Expanded(
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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: kBackgroundColor.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${item.typeLine}'.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: kThirdColor)),
                          Text('TAB: ${item.stashName}'.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.75),
                              ))
                        ],
                      ),
                    ),
                    Text(
                      '${item.stackSize ?? ''}',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kPrimaryColor),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
