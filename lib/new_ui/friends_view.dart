import 'package:flutter/material.dart';
import 'package:poe_currency/models/user/user.dart';

class FriendsView extends StatelessWidget {
  final User currentUser;

  const FriendsView({@required this.currentUser}) : assert(currentUser != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text('Cool, cool friends!'), _FriendsList()],
    );
  }
}

/*class _FriendsList extends StatelessWidget {
  const _FriendsList({this.friends});

  final List<User> friends;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PricingBloc, PricingState>(builder: (context, state) {
      bool isPriced = false;

      if (state is PricingSuccess) {
        isPriced = true;
      }

      return Column(
        children: [
          Expanded(
            flex: 1,
            child: _ItemListHeader(),
          ),
          Expanded(
            flex: 10,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return _ItemListItem(item: items[index], isPriced: isPriced);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: items.length),
          ),
        ],
      );
    });
  }
}

class _ItemListHeader extends StatelessWidget {
  const _ItemListHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 1,
            child:
                Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child: Text('Last updated',
                style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }
}

class _ItemListItem extends StatelessWidget {
  const _ItemListItem({@required this.item, this.isPriced = false})
      : assert(item != null);

  final Item item;
  final bool isPriced;

  @override
  Widget build(BuildContext context) {
    final Text name = Text('${item.typeLine}',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: kPrimaryColor));
    final Text tab = Text(
      '${item.tabs.toString().replaceFirst('[', '').replaceFirst(']', '')}',
      overflow: TextOverflow.ellipsis,
    );
    final Text links =
        item.socketLinks != 0 ? Text('${item.socketLinks}') : Text('N/A');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: _ItemIcon(iconUrl: item.icon)),
        Expanded(flex: 1, child: name),
        Expanded(flex: 1, child: tab),
      ],
    );
  }
}*/
