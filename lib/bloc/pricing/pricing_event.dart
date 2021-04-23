part of 'pricing_bloc.dart';

abstract class PricingEvent extends Equatable {
  const PricingEvent();
}

class PricingRequested extends PricingEvent {
  final String username;
  final List<Item> itemsToPrice;

  const PricingRequested({@required this.username, @required this.itemsToPrice})
      : assert(itemsToPrice != null);

  @override
  List<Object> get props => [username, itemsToPrice];
}
