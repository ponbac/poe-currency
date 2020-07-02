import 'package:flutter/material.dart';
import 'package:poe_currency/secrets.dart';
import 'package:poe_currency/screens/start_screen.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _sessionIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _goToStartScreen() {
      poeAccountName = _nameController.text;
      poeSessionId = _sessionIdController.text;

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => new StartScreen()));
    }

    void _goToStartScreenTesting() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => new StartScreen()));
    }

    return Scaffold(
        body: Column(
      children: [
        TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Account name')),
        TextField(
          controller: _sessionIdController,
          decoration: InputDecoration(hintText: 'Session ID'),
        ),
        RaisedButton(child: Text('GO!'), onPressed: _goToStartScreen),
        RaisedButton(child: Text('testing'), onPressed: _goToStartScreenTesting)
      ],
    ));
  }
}
