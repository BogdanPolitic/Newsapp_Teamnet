import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news_app/state_view_model.dart';
import '../models/app_state.dart';
import '../state_view_model.dart';


class SignUp extends StatefulWidget {
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
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
                            //_email = input;
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
                            //_password = input;
                            _loginData['password'] = input;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.length < 5) return 'Invalid password';
                          },
                          onSaved: (input) {
                            //_password = input;
                            _loginData['retypedPassword'] = input;
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        RaisedButton(
                          child: Text('Sign up'),
                          onPressed: () {
                            if (_key.currentState.validate())
                              _key.currentState.save();
                            stateViewModel.navigateToSignIn(_loginData);
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