import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/navigation_bloc.dart';
import 'package:poe_currency/models/nav_page.dart';

import '../constants.dart';
import '../secrets.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sessionIdController = TextEditingController();

  void _displayStash(BuildContext context) {
    poeAccountName = _nameController.text;
    poeSessionId = _sessionIdController.text;

    BlocProvider.of<NavigationBloc>(context)
        .add(PageRequested(page: NavPage.STASH));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.blue),
        child: Column(
          children: [
            _LoginField(textController: _nameController, hint: 'Account name'),
            _LoginField(
                textController: _sessionIdController, hint: 'Session ID'),
            _SubmitButton(text: 'GO!', onPressed: () => _displayStash(context)),
          ],
        ),
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({this.textController, this.hint})
      : assert(textController != null),
        assert(hint != null);

  final TextEditingController textController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
          controller: textController,
          decoration: InputDecoration(
              hintText: hint, hintStyle: TextStyle(color: kPrimaryColor))),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({this.text, this.onPressed})
      : assert(text != null),
        assert(onPressed != null);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: RaisedButton(child: Text(text), onPressed: onPressed),
    );
  }
}
