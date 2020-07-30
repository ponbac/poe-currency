import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/snapshot_bloc.dart';
import 'package:poe_currency/models/user/snapshot.dart';
import 'package:poe_currency/models/user/user.dart';

import '../constants.dart';

class FriendsView extends StatelessWidget {
  final User currentUser;

  const FriendsView({@required this.currentUser}) : assert(currentUser != null);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SnapshotBloc>(context)
        .add(LatestSnapshotRequested(userList: currentUser.friends));

    return BlocBuilder<SnapshotBloc, SnapshotState>(builder: (context, state) {
      if (state is SnapshotListLoadSuccess) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            _AddFriendButton(),
            Expanded(
                child: _FriendsList(
              snapshots: state.snapshots,
            )),
            Spacer()
          ],
        );
      }

      return Center(child: CircularProgressIndicator());
    });
  }
}

class _AddFriendButton extends StatelessWidget {
  const _AddFriendButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.add,
          color: kTextColor,
        ),
        onPressed: () => print('Add friend dialog to pop up!'));
  }
}

class _FriendsList extends StatelessWidget {
  const _FriendsList({@required this.snapshots});

  final List<Snapshot> snapshots;

  @override
  Widget build(BuildContext context) {
    if (snapshots.length == 0) {
      return Center(child: Text('No friends added!'));
    } else {
      return Column(
        children: [
          Expanded(
            flex: 1,
            child: _FriendsListHeader(),
          ),
          Expanded(
            flex: 10,
            child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return _FriendsListItem(item: snapshots[index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
                itemCount: snapshots.length),
          ),
        ],
      );
    }
  }
}

class _FriendsListHeader extends StatelessWidget {
  const _FriendsListHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Expanded(
            flex: 1,
            child: Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 1,
            child: Text('Stash value',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
            flex: 1,
            child: Text('Last updated',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Spacer()
      ],
    );
  }
}

class _FriendsListItem extends StatelessWidget {
  const _FriendsListItem({@required this.item}) : assert(item != null);

  final Snapshot item;

  @override
  Widget build(BuildContext context) {
    //print('${item.username}, ${item.value}');

    final Text username = Text(
      '${item.username}',
      overflow: TextOverflow.ellipsis,
    );
    final Text value = Text(
      '${item.value}',
      style: TextStyle(color: kPrimaryColor),
      overflow: TextOverflow.ellipsis,
    );
    final String formattedDate = item.date.toString().split('.')[0];
    final Text lastUpdated = Text('$formattedDate');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Expanded(flex: 1, child: username),
        Expanded(flex: 1, child: value),
        Expanded(flex: 1, child: lastUpdated),
        Spacer()
      ],
    );
  }
}
