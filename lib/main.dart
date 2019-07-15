import 'package:flutter/material.dart';
import 'package:newsapp/pages/signIn.dart';
import 'pages/welcome.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './models/app_state.dart';
import './reducers/app_reducer.dart';
import 'middleware/middleware.dart';
//import './actions/actions.dart';
//import './filtre_buttons.dart';

class Keys {
  static final navKey = GlobalKey<NavigatorState>();
}

void main() {
  final store = Store<AppState>(
      appReducer,
      initialState: AppState.initial(),
      middleware: middlewares()
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  print('Initial state: ${store.state}');

  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        navigatorKey: Keys.navKey,
        title: 'Flutter Redux Demo',
        home: MyApp(),
        routes: {
          '/login': (context) => SignIn()
        },
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