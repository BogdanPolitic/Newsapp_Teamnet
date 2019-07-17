import 'package:flutter/material.dart';
import './signIn.dart';
import './signUp.dart';

class Authentication extends StatefulWidget {
  @override
  State<Authentication> createState() {
    return AuthenticationState();
  }
}

class AuthenticationState extends State<Authentication> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                onPressed: navigateToSignIn,
                child: Text('Sign in'),
              ),
              RaisedButton(
                onPressed: navigateToSignUp,
                child: Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignIn(),
        fullscreenDialog: true,
      ),
    );
  }
  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(),
        fullscreenDialog: true,
      ),
    );
  }
}