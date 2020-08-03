part of 'filter_bloc.dart';

enum FilterType { MOST_EXPENSIVE }

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class FilterSearchRequested extends FilterEvent {
  final String searchString;

  const FilterSearchRequested({@required this.searchString})
      : assert(searchString != null);

  @override
  List<Object> get props => [searchString];
}

class FilterRequested extends FilterEvent {
  final FilterType filterType;
  final List<Item> itemsToFilter;

  const FilterRequested({@required this.filterType, this.itemsToFilter})
      : assert(filterType != null);

  List<Object> get props => [filterType];
}
