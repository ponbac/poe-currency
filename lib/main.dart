import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/repositories/stash_api_client.dart';
import 'package:poe_currency/screens/start_screen.dart';

void main() {
  final StashApiClient stashApiClient =
      StashApiClient();

  runApp(MyApp(stashApiClient: stashApiClient,));
}

class MyApp extends StatelessWidget {
  final StashApiClient stashApiClient;

  MyApp({Key key, @required this.stashApiClient})
      : assert(stashApiClient != null),
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
        create: (context) => StashBloc(stashApiClient: stashApiClient),
        child: StartScreen(),
      ),
    );
  }
}
