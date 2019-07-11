import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import '../models/app_state.dart';
import '../reducers/app_reducer.dart';
import '../actions/actions.dart';
import './homeMihnea.dart';

class SignIn extends StatefulWidget {
  State<SignIn> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  Store<AppState> store =
      Store(appReducer, initialState: AppState(email: '', password: '', retypedPassword: ''), middleware: [
    LoggingMiddleware<dynamic>.printer(),
  ]);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SizedBox(
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
                        StoreConnector<AppState, String>(
                          converter: (store) => store.state.email,
                          builder: (context, arg) => TextFormField(
                            validator: (input) {
                              if (input.length < 5)
                                return 'Invalid e-mail';
                            },
                            onSaved: (input) {
                              //_email = input;
                              store.dispatch(UpdateEmail(input));
                            },
                            decoration: InputDecoration(labelText: 'E-mail'),
                          ),
                        ),
                        StoreConnector<AppState, String>(
                          converter: (store) => store.state.password,
                          builder: (context, arg) => TextFormField(
                            validator: (input) {
                              if (input.length < 5)
                                return 'Invalid password';
                            },
                            onSaved: (input) {
                              //_password = input;
                              store.dispatch(UpdatePassword(input));
                              print('READ: ${store.state.password}');
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                        ),
                        StoreConnector<AppState, AppState>(
                          converter: (store) => store.state,
                          builder: (context, arg) => RaisedButton(
                            child: Text('Sign in'),
                            onPressed: () {
                              navigateToHome();
                            },
                          ),
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

  void navigateToHome() async {
    final _formState = _key.currentState;
    if (_formState.validate()) {
      _formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: store.state.email, password: store.state.password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHome(user: user)));
      } catch (e) {
        print(e);
      }
    }
  }

  void navigatePop() {
    Navigator.pop(context);
  }
}
