import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/pages/signIn.dart';
import 'pages/welcome.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './models/app_state.dart';
import './reducers/app_reducer.dart';
import 'middleware/middleware.dart';

//void main() async {
//  final Firestore firestore = Firestore.instance;
//  await firestore.settings(persistenceEnabled:false, timestampsInSnapshotsEnabled: true);
//  runApp(MyApp());
//}
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