import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './models/models.dart';
import './models/app_state.dart';
import './reducers/app_reducer.dart';
//import './actions/actions.dart';
//import './filtre_buttons.dart';

bool someVar = false;

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(), // Set initial state to false
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
        home: MyApp(),
      ),
    ),
  );
}
//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox.expand(
          child: RadialMenu(),
        ),
      ),
    );
  }
}