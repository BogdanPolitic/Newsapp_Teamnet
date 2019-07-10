import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';
import '../errors/passwordsNotMatching.dart';
import '../redux.dart';

class SignUp extends StatefulWidget {
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _retypedPassword;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
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
                      TextFormField(
                        validator: (input) {
                          if (input.length < 5) return 'Invalid e-mail';
                          return null;
                        },
                        onSaved: (input) => _email = input,
                        decoration: InputDecoration(labelText: 'E-mail'),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.length < 6) return 'Invalid password';
                          return null;
                        },
                        onSaved: (input) => _password = input,
                        decoration: InputDecoration(labelText: 'Password'),
                      ),
                      TextFormField(
                        validator: (input) {
                          if (input.length < 6) return 'Invalid password';
                          return null;
                        },
                        onSaved: (input) => _retypedPassword = input,
                        decoration:
                            InputDecoration(labelText: 'Retype password'),
                      ),
                      RaisedButton(
                        child: Text('Sign up'),
                        onPressed: navigateToHome,
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
              ],
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
      if (_password != _retypedPassword) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordsNotMatching()));
      } else {
        try {
          FirebaseUser user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email, password: _password);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        } catch (e) {
          print(e);
          print('NU MERGFEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE');
        }
      }
    }
  }

  void navigatePop() {
    Navigator.pop(context);
  }
}
