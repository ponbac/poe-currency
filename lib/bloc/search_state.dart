part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchInProgress extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Item> searchResult;

  const SearchSuccess({@required this.searchResult}) : assert(searchResult != null);

  @override
  List<Object> get props => [searchResult];
}

class SearchFailure extends SearchState {}