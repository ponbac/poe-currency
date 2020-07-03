part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchRequested extends SearchEvent {
  final String searchString;

  const SearchRequested({@required this.searchString})
      : assert(searchString != null);

  @override
  List<Object> get props => [searchString];
}
