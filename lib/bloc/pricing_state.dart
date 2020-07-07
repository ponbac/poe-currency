part of 'pricing_bloc.dart';

abstract class PricingState extends Equatable {
  const PricingState();

  @override
  List<Object> get props => [];
}

class PricingInitial extends PricingState {}

class PricingInProgress extends PricingState {}

class PricingSuccess extends PricingState {
  final List<Item> pricedItems;

  const PricingSuccess({@required this.pricedItems});

  @override
  List<Object> get props => [pricedItems];
}

class PricingFailure extends PricingState {}