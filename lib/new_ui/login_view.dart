import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poe_currency/bloc/login_bloc.dart';
import 'package:poe_currency/bloc/navigation_bloc.dart';
import 'package:poe_currency/models/nav_page.dart';

import '../constants.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: kPrimaryColor),
          child:
              BlocBuilder<NavigationBloc, NavPage>(builder: (context, state) {
            if (state == NavPage.LOGIN) {
              return _Login();
            }
            if (state == NavPage.REGISTER) {
              return _Register();
            }

            return Text('Invalid state: ${state.toString()}');
          })),
    );
  }
}

class _Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _displayStash(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.length > 1 && password.length > 6) {
      BlocProvider.of<LoginBloc>(context)
          .add(LoginRequested(username: username, password: password));
    } else {
      print('Non-valid credentials!');
    }
  }

  void _showSignUpPage(BuildContext context) {
    BlocProvider.of<NavigationBloc>(context)
        .add(PageRequested(page: NavPage.REGISTER));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _TopImage(
            image: AssetImage('assets/images/chaos-orb.png'),
          ),
        ),
        Flexible(
            child: _LoginField(
                textController: _usernameController, hint: 'Username')),
        Flexible(
            child: _LoginField(
                textController: _passwordController,
                hint: 'Password',
                isPassword: true)),
        Flexible(
            child: _SubmitButton(
                text: 'GO!', onPressed: () => _displayStash(context))),
        Flexible(
          child: _SubmitButton(
              text: 'Register', onPressed: () => _showSignUpPage(context)),
        )
      ],
    );
  }
}

class _Register extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _sessionIdController = TextEditingController();

  void _toLogin(BuildContext context) {
    BlocProvider.of<NavigationBloc>(context)
        .add(PageRequested(page: NavPage.LOGIN));
  }

  void _signUp(BuildContext context, String username, String password,
      String accountName, String poesessid) {
    BlocProvider.of<LoginBloc>(context).add(SignUpRequested(
        username: username,
        password: password,
        accountname: accountName,
        poesessid: poesessid));

    _toLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _TopImage(
            image: AssetImage('assets/images/chaos-orb.png'),
          ),
        ),
        Flexible(
            child: _LoginField(
                textController: _usernameController, hint: 'Username')),
        Flexible(
            child: _LoginField(
                textController: _passwordController,
                hint: 'Password',
                isPassword: true)),
        Flexible(
          child: _LoginField(
              textController: _accountNameController, hint: 'PoE Account Name'),
        ),
        Flexible(
            child: _LoginField(
                textController: _sessionIdController, hint: 'Session ID')),
        Flexible(
          child: _SubmitButton(
              text: 'Register',
              onPressed: () => _signUp(
                  context,
                  _usernameController.text,
                  _passwordController.text,
                  _accountNameController.text,
                  _sessionIdController.text)),
        ),
        Flexible(
            child: _SubmitButton(
                text: 'Back', onPressed: () => _toLogin(context))),
      ],
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
  const _LoginField(
      {@required this.textController,
      @required this.hint,
      this.isPassword = false})
      : assert(textController != null),
        assert(hint != null);

  final TextEditingController textController;
  final String hint;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
          obscureText: isPassword,
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
