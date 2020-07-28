import 'package:flutter/material.dart';
import 'package:poe_currency/models/user.dart';

class FriendsView extends StatelessWidget {
  final User currentUser;

  const FriendsView({@required this.currentUser}) : assert(currentUser != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text('Cool, cool friends!')],
    );
  }
}
