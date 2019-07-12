// lib/reducers/app_reducer.dart
import 'package:newsapp/models/app_state.dart';

import '../reducers/test_reducer.dart';
import '../actions/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is TestAction) {
    return reducers(state, action);
  } else if (action is ChangeFilterCheckers) {
    return AppState();
  } else if (action is UpdateLoginDataAction) {
    return reducers(state, action);
  } else {
    return null;
  }
}