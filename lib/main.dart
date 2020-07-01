import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import 'package:poe_currency/repositories/stash_repository.dart';
import 'package:poe_currency/repositories/stash_repository_web.dart';
import 'package:poe_currency/screens/start_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  StashRepository stashRepository;

  if (kIsWeb) {
    stashRepository = new StashRepositoryWeb(stashApiClient: new StashApiClient());
  } else {
    stashRepository = new StashRepository(stashApiClient: new StashApiClient());
  }

  runApp(MyApp(
    stashRepository: stashRepository,
  ));
}

class MyApp extends StatelessWidget {
  final StashRepository stashRepository;

  MyApp({Key key, @required this.stashRepository})
      : assert(stashRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoE Currency',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => StashBloc(stashRepository: stashRepository),
        child: StartScreen(),
      ),
    );
  }
}
