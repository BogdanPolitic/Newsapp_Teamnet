import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news_app/state_view_model.dart';
import '../models/app_state.dart';

class SignIn extends StatefulWidget {
  State<SignIn> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Map<String, String> _loginData = {};
    return Scaffold(
      body: StoreConnector<AppState, StateViewModel>(
        converter: (store) => StateViewModel.fromStore(store),
        builder: (context, stateViewModel) => SizedBox(
          child: Form(
            key: _key,
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          validator: (input) {
                            if (input.length < 5)
                              return 'Invalid e-mail';
                          },
                          onSaved: (input) {
                            _loginData['email'] = input;
                          },
                          decoration: InputDecoration(labelText: 'E-mail'),
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.length < 5)
                              return 'Invalid password';
                          },
                          onSaved: (input) {
                            _loginData['password'] = input;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        RaisedButton(
                          child: Text('Sign in'),
                          onPressed: () {
                            if (_key.currentState.validate())
                              _key.currentState.save();
                            stateViewModel.navigateToHome(_loginData);
                          },
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    child: Transform.scale(
                      scale: 3,
                      child: Icon(Icons.cancel),
                    ),
                    onPressed: navigatePop,
                  ),
                  Text(
                    '',
                    style: TextStyle(fontSize: 50),
                  ),
                  StoreConnector<AppState, String>(
                    converter: (store) => store.state.email,
                    builder: (context, arg) => Text(arg),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigatePop() {
    Navigator.pop(context);
  }
}