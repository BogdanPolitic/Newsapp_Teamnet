import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/actions/actions.dart';
import 'package:newsapp/main.dart';
import 'package:newsapp/models/app_state.dart';
import 'package:newsapp/pages/homeMihnea.dart';
import 'package:newsapp/pages/signIn.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> middlewares() => [
  TypedMiddleware<AppState, NavigateToHome>(_navigateToHome),
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