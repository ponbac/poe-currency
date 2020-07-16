import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/navigation_bloc.dart';
import 'package:poe_currency/bloc/stash_bloc.dart';
import 'package:poe_currency/models/nav_page.dart';

import '../constants.dart';
import '../secrets.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sessionIdController = TextEditingController();

  void _displayStash(BuildContext context) {
    poeAccountName = _nameController.text;
    poeSessionId = _sessionIdController.text;

    if (poeAccountName.length > 1 && poeSessionId.length > 6) {
    BlocProvider.of<NavigationBloc>(context)
        .add(PageRequested(page: NavPage.STASH));
    BlocProvider.of<StashBloc>(context).add(
        StashRequested(sessionId: poeSessionId, accountName: poeAccountName));
    } else {
      print('Non-valid credentials!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TopImage(
              image: AssetImage('assets/images/chaos-orb.png'),
            ),
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

class _TopImage extends StatelessWidget {
  const _TopImage({@required this.image}) : assert(image != null);

  final AssetImage image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        height: 100,
        width: 100,
        color: kBackgroundColor,
        child: Image(
          height: 90,
          width: 90,
          image: image,
        ),
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({@required this.textController, @required this.hint})
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
          style: TextStyle(color: kBackgroundColor),
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: kBackgroundColor.withOpacity(0.5)))),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({@required this.text, @required this.onPressed})
      : assert(text != null),
        assert(onPressed != null);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: RaisedButton(
          child: Text(
            text,
            style: TextStyle(color: kPrimaryColor),
          ),
          onPressed: onPressed),
    );
  }
}
