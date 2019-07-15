import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './signIn.dart';
import '../errors/passwordsNotMatching.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import '../models/app_state.dart';
import '../reducers/app_reducer.dart';

class SignUp extends StatefulWidget {
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  Store<AppState> store = Store(appReducer,
      initialState: AppState(email: '', password: '', retypedPassword: ''),
      middleware: [
        LoggingMiddleware<dynamic>.printer(),
      ]);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    Map<String, String> _loginData = {};
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
                              if (input.length < 5) return 'Invalid e-mail';
                            },
                            onSaved: (input) {
                              _loginData['email'] = input;
                            },
                            decoration: InputDecoration(labelText: 'E-mail'),
                          ),
                        ),
                        StoreConnector<AppState, String>(
                          converter: (store) => store.state.password,
                          builder: (context, arg) => TextFormField(
                            validator: (input) {
                              if (input.length < 5) return 'Invalid password';
                            },
                            onSaved: (input) {
                              //_password = input;
                              _loginData['password'] = input;
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                        ),
                        StoreConnector<AppState, String>(
                          converter: (store) => store.state.retypedPassword,
                          builder: (context, arg) => TextFormField(
                            validator: (input) {
                              if (input.length < 5) return 'Invalid password';
                            },
                            onSaved: (input) {
                              //_password = input;
                              _loginData['retypedPassword'] = input;
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                          ),
                        ),
                        RaisedButton(
                            child: Text('Sign up'),
                            onPressed: () {
                              navigateToHome();
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

  void navigateToHome() async {
    final _formState = _key.currentState;
    if (_formState.validate()) {
      _formState.save();
      if (store.state.password != store.state.retypedPassword) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PasswordsNotMatching(messages: [
                      'Whoops!',
                      'Passwords not matching!',
                      'Try again.'
                    ])));
      } else {
        try {
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: store.state.email, password: store.state.password);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
        } catch (e) {
          print(e);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PasswordsNotMatching(
                messages: [
                  'Whoops!',
                  'This user already exists!',
                  'Try again.'
                ],
              ),
            ),
          );
        }
      }
    }
  }

  void navigatePop() {
    Navigator.pop(context);
  }
}
