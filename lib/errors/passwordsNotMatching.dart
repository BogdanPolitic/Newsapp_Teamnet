import 'package:flutter/material.dart';

class PasswordsNotMatching extends StatefulWidget {
  State<PasswordsNotMatching> createState() {
    return PasswordsNotMatchingState();
  }
}

class PasswordsNotMatchingState extends State<PasswordsNotMatching> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Whoops!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Passwords not matching!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Try again.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 2,
            child: FloatingActionButton(
              child: Icon(Icons.highlight_off),
              onPressed: navigatePop,
            ),
          ),
          Text('',
              style: TextStyle(
                fontSize: 50,
              )),
        ],
      ),
    );
  }

  void navigatePop() {
    Navigator.pop(context);
  }
}
