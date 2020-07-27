part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable{
  const NavigationEvent();
}

class PageRequested extends NavigationEvent {
  final NavPage page;

  const PageRequested({@required this.page})
      : assert(page != null);

  @override
  List<Object> get props => [page];
}