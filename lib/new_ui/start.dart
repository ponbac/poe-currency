import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/navigation/navigation_bloc.dart';
import 'package:poe_currency/bloc/pricing/pricing_bloc.dart';
import 'package:poe_currency/bloc/snapshot/snapshot_bloc.dart';
import 'package:poe_currency/bloc/stash/stash_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/new_ui/main_area.dart';
import 'package:poe_currency/repositories/pricing_repository.dart';

// Inspiration: https://dribbble.com/shots/11663910--Exploration-Bookmark-App
//              https://www.youtube.com/watch?v=E6fLm5XlJDY
//              https://github.com/abuanwar072/Protfolio-Website-Flutter-Web

class Start extends StatelessWidget {
  const Start({@required this.pricingRepository})
      : assert(pricingRepository != null);

  final PricingRepository pricingRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
          child: MultiBlocProvider(providers: [
            BlocProvider<PricingBloc>(
              create: (context) => PricingBloc(
                  pricingRepository: pricingRepository,
                  stashBloc: BlocProvider.of<StashBloc>(context)),
            ),
            BlocProvider<SnapshotBloc>(
              create: (context) =>
                  SnapshotBloc(pricingRepository: pricingRepository),
            )
          ], child: MainArea()),
        ));
  }
}
