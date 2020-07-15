import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/filter_bloc.dart';
import 'package:poe_currency/bloc/tab_bloc.dart';
import 'package:poe_currency/constants.dart';

// TODO: Merge with _StashView

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                _Title(
                  titleText: 'Stash',
                ),
                _FilterButton()
              ],
            ),
          ),
          Spacer(flex: 4),
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

        return Text(
          '$tabName${tabValue != null ? ', ' + tabValue + 'C' : ''}',
          style: titleStyle.copyWith(fontSize: 30),
          overflow: TextOverflow.ellipsis,
        );
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
