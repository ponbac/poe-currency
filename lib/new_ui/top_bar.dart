import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:poe_currency/bloc/filter/filter_bloc.dart';
import 'package:poe_currency/bloc/stash/stash_bloc.dart';
import 'package:poe_currency/bloc/tab/tab_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/models/user/user.dart';

// TODO: Merge with _StashView

class TopBar extends StatelessWidget {
  const TopBar({@required this.user}) : assert(user != null);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Flexible(
                  flex: 4,
                  child: _Title(
                    titleText: 'Items',
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Flexible(child: _FilterButton()),
                      Flexible(child: _RefreshButton(user: user))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 3),
          Expanded(flex: 2, child: _SearchField()),
          Spacer()
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({@required this.titleText}) : assert(titleText != null);

  final String titleText;
  final TextStyle titleStyle = const TextStyle(
    color: kTextColor,
    fontSize: 40,
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(builder: (context, state) {
      if (state is TabUpdated) {
        String tabName = state.stashTab.name;
        String tabValue = state.stashTab.totalValue.toString();

        return RichText(
            overflow: TextOverflow.visible,
            text: TextSpan(
                text: '$tabName',
                style: titleStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: '${tabValue != null ? ' ' + tabValue + 'C' : ''}',
                      style: titleStyle.copyWith(color: kPrimaryColor))
                ]));
      }

      return Text(titleText, style: titleStyle);
    });
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.sort,
          color: kTextColor,
        ),
        onPressed: () => BlocProvider.of<FilterBloc>(context)
            .add(FilterRequested(filterType: FilterType.MOST_EXPENSIVE)));
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton({@required this.user}) : assert(user != null);

  final User user;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.refresh,
          color: kTextColor,
        ),
        onPressed: () => BlocProvider.of<StashBloc>(context).add(StashRequested(
            username: user.username,
            sessionId: user.poeSessionId,
            accountName: user.accountname)));
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: kTextColor, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            hintStyle: TextStyle(
              color: kTextColor.withOpacity(0.5),
              fontSize: 14,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
            ),
            hintText: 'Enter a search term...',
          ),
          style: TextStyle(
            color: kTextColor,
            fontSize: 14,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w400,
          ),
          onChanged: (text) => BlocProvider.of<FilterBloc>(context)
              .add(FilterSearchRequested(searchString: searchController.text))),
    );
  }
}
