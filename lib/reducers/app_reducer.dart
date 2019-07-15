// lib/reducers/app_reducer.dart
import 'package:newsapp/models/app_state.dart';

import '../reducers/test_reducer.dart';
import '../actions/actions.dart';

AppState appReducer(AppState state, dynamic action) {

  return reducers(state, action);

}