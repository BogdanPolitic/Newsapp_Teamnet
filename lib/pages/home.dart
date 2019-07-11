import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import '../models/app_state.dart';

class Home extends StatelessWidget {
  FirebaseUser user;
  Home({this.user});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SizedBox(
        child: Container(
          child: Text(
            'Home Page ${user.displayName}',
          ),
        ),
      ),
    );
  }

}