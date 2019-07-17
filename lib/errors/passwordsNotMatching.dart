import 'package:flutter/material.dart';

class PasswordsNotMatching extends StatefulWidget {
  List<String> messages = [];
  PasswordsNotMatching({this.messages});
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
                      widget.messages[0],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.messages[1],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.messages[2],
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