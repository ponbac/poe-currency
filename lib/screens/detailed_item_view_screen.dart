import 'package:flutter/material.dart';
import 'package:poe_currency/models/item.dart';

class DetailedItemViewScreen extends StatelessWidget {
  final Item item;

  DetailedItemViewScreen({@required this.item}) : assert(item != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${item.descrText}'),
            RaisedButton(
                child: Text('Back to stash'),
                onPressed: () => Navigator.pop(context))
          ],
        ),
      ),
    );
  }
}
