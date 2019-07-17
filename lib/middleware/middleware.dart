import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/actions/actions.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/app_state.dart';
import 'package:news_app/pages/news.dart';
import 'package:news_app/pages/signIn.dart';
import 'package:redux/redux.dart';
import 'package:news_app/errors/passwordsNotMatching.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<Middleware<AppState>> middlewares() => [
  TypedMiddleware<AppState, NavigateToHome>(_navigateToHome),
  TypedMiddleware<AppState, NavigateToSignIn>(_navigateToSignIn),
];

Widget createUserDocumentAndNavigate({user}) {
  return StreamBuilder(
      stream: Firestore.instance.collection('usersAndNews').document('info').collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        Firestore.instance.collection('usersAndNews').document('info').collection('users').document('${user.uid}').setData({'favourites' : {}, 'likes' : {}});
        print('HAHAHAHA ${user.uid}');
        return SignIn();
      }
  );
}

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
    Keys.navKey.currentState.push(MaterialPageRoute(builder: (context) => createUserDocumentAndNavigate(user: user)));
  } catch (e) {
    print(e);
  }
}