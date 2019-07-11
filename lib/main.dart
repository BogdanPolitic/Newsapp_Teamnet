// lib/main.dart
// Gasit tutorial asemanator cu ce a facut Cristi astazi la prezentare
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:Newsapp_Teamnet/models/models.dart';
import 'package:Newsapp_Teamnet/reducers/app_reducer.dart';
import 'package:Newsapp_Teamnet/actions/actions.dart';
import 'package:Newsapp_Teamnet/filtre_buttons.dart';

bool someVar = false;

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(reduxSetup: someVar), // Set initial state to false
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  print('Initial state: ${store.state}');

  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Demo',
        home: MyHomeApp(),
      ),
    ),
  );
}

class MyHomeApp extends StatelessWidget {

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
                  Text('user\'s name here'),
                  Text('user\'s email here'),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
