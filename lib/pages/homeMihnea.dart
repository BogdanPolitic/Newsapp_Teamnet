// lib/main.dart
// Gasit tutorial asemanator cu ce a facut Cristi astazi la prezentare
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../models/models.dart';
import '../reducers/app_reducer.dart';
import '../actions/actions.dart';
import '../filtre_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool someVar = false;

class MyHome extends StatelessWidget {
  FirebaseUser user;
  MyHome({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text('user\'s name here: ${user.email}'),
                  Text('user\'s email here:'),
                ],
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ExpansionTile(
              title: Text('Filters'),
              children: <Widget>[
                MakeFilterButtons(),
              ],
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Text('Flutter Redux Demo'),
      ),
      // Connect to the store
      body: StoreConnector<AppState, bool>(
        converter: (Store<AppState> store) => store.state.reduxSetup,
        builder: (BuildContext context, bool reduxSetup) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Redux is working: $reduxSetup'),
                RaisedButton(
                  child: Text('Dispatch action'),
                  onPressed: () => StoreProvider.of<AppState>(context)
                      .dispatch(TestAction(someVar)),
                ),
                Text('${user.email}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
