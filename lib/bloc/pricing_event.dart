part of 'pricing_bloc.dart';

abstract class PricingEvent extends Equatable {
  const PricingEvent();
}

class PricingRequested extends PricingEvent {
  final List<Item> itemsToPrice;

  const PricingRequested({@required this.itemsToPrice})
      : assert(itemsToPrice != null);

  @override
  List<Object> get props => [itemsToPrice];
}
