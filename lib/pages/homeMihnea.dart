// lib/main.dart
// Gasit tutorial asemanator cu ce a facut Cristi astazi la prezentare
import 'package:flutter/material.dart';
import 'package:newsapp/models/app_state.dart';
import 'package:newsapp/state_view_model.dart';
import 'package:newsapp/pages/map_screen.dart';
//import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
//import '../reducers/app_reducer.dart';
import '../filtre_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
                    height: MediaQuery.of(context).size.height * 0.125,

                    child: CircleAvatar(

                      backgroundColor: Colors.lightBlueAccent,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Text(
                    'user\'s name here:',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.021,
                    ),
                  ),
                  Text(
                    'user\'s email here: ${user.email}',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.021,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.map,
                color: Colors.black,
              ),
              title: Text(
                  'News Maps',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                  )
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
              },
            ),
            ExpansionTile(
              leading: Icon(
                Icons.sort,
                color: Colors.black,
              ),
              title: Text(
                'Filters',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                ),
              ),
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
      body: StoreConnector<AppState, StateViewModel>(
        converter: (store) => StateViewModel.fromStore(store),
        builder: (context, StateViewModel stateViewModel) {
          return Center(
            child: Column(
              children: <Widget>[
                Container (
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Row(
                            children: <Widget>[
                              Text (
                                  'Title'
                              ),
                              Switch (
                                activeColor: Colors.orangeAccent,
                                activeTrackColor: Colors.white,
                                inactiveThumbColor: Colors.orangeAccent,
                                inactiveTrackColor: Colors.white,
                                value: stateViewModel.switchNameOrDate,
                                onChanged: (bool someVal) {
                                  print(stateViewModel.switchNameOrDate);
                                  stateViewModel.sortNameOrDate();
                                },
                              ),
                              Text (
                                  'Name'
                              ),
                            ]
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_upward,
                            ),
                            Switch (
                              activeColor: Colors.orangeAccent,
                              activeTrackColor: Colors.white,
                              inactiveThumbColor: Colors.orangeAccent,
                              inactiveTrackColor: Colors.white,
                              value: stateViewModel.switchIncOrDec,
                              onChanged: (bool someVal) {
                                stateViewModel.sortIncOrDec();
                              },
                            ),
                            Icon(
                              Icons.arrow_downward,
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Text(
                  'Redux is working: ${!stateViewModel.reduxSetup}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                ),
                RaisedButton(
                    child: Text(
                      'Dispatch action',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.021,
                      ),
                    ),
                    onPressed: () {
//                    print('aintrat');
                      return stateViewModel.testAction();
                    }
                ),
                Text(
                  '${user.email}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
