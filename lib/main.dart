import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/login_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/constants.dart';
import 'package:poe_currency/new_ui/start.dart';
import 'package:poe_currency/repositories/pricing_api_client.dart';
import 'package:poe_currency/repositories/pricing_repository.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import 'package:poe_currency/repositories/stash_repository.dart';
import 'package:poe_currency/repositories/stash_repository_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:poe_currency/repositories/user_repository.dart';


void main() {
  StashRepository stashRepository;
  PricingRepository pricingRepository =
      new PricingRepository(pricingApiClient: new PricingApiClient());
  UserRepository userRepository = new UserRepository();

  if (kIsWeb) {
    stashRepository =
        new StashRepositoryWeb(stashApiClient: new StashApiClient());
  } else {
    stashRepository = new StashRepository(stashApiClient: new StashApiClient());
  }

  runApp(MyApp(
      stashRepository: stashRepository,
      pricingRepository: pricingRepository,
      userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final StashRepository stashRepository;
  final PricingRepository pricingRepository;
  final UserRepository userRepository;

  MyApp(
      {Key key,
      @required this.stashRepository,
      @required this.pricingRepository,
      @required this.userRepository})
      : assert(stashRepository != null &&
            pricingRepository != null &&
            userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoE Stash Explorer',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kThirdColor,
              displayColor: kThirdColor,
              fontFamily: 'Ubuntu'),
          buttonTheme: ButtonThemeData(
            buttonColor: kBackgroundColor, //  <-- dark color
            textTheme: ButtonTextTheme
                .primary, //  <-- this auto selects the right color
          )),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<StashBloc>(
              create: (context) => StashBloc(stashRepository: stashRepository)),
          BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository: userRepository))
        ],
        child: Start(
          pricingRepository: pricingRepository,
        ),
      ),
    );
  }
}
