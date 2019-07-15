import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/actions/actions.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/models/app_state.dart';
import 'package:newsapp/pages/homeMihnea.dart';
import 'package:newsapp/pages/signIn.dart';
import 'package:redux/redux.dart';
import 'package:newsapp/errors/passwordsNotMatching.dart';

List<Middleware<AppState>> middlewares() => [
  TypedMiddleware<AppState, NavigateToHome>(_navigateToHome),
  TypedMiddleware<AppState, NavigateToSignIn>(_navigateToSignIn),
];

void _navigateToHome(Store<AppState> store, NavigateToHome action, NextDispatcher next) async {
  try {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: action.email, password: action.password);
    Keys.navKey.currentState.push(MaterialPageRoute(builder: (context) => MyHome(user: user,)));
  } catch (e) {
    print(e);
  }
}

void _navigateToSignIn(Store<AppState> store, NavigateToSignIn action, NextDispatcher next) async {
  if (action.password != action.retypedPassword) {
    Keys.navKey.currentState.push(MaterialPageRoute(
        builder: (context) => PasswordsNotMatching(messages: [
          'Whoops!',
          'Passwords not matching!',
          'Try again.'
        ])));
  }
  try {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: action.email, password: action.password);
    Keys.navKey.currentState.push(MaterialPageRoute(builder: (context) => SignIn()));
  } catch (e) {
    print(e);
  }
}