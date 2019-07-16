import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  FirebaseUser user;
  Home({this.user});
  @override
  Widget build(BuildContext context) {
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