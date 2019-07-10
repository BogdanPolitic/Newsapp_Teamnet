import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';

class SignIn extends StatefulWidget {
  State<SignIn> createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn> {
  String _email, _password;
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
                      RaisedButton(
                        child: Text('Sign in'),
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
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print(e);
      }
    }
  }

  void navigatePop() {
    Navigator.pop(context);
  }
}
