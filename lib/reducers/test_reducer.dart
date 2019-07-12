// lib/reducers/test_reducer.dart
import 'package:newsapp/models/app_state.dart';
import 'package:redux/redux.dart';
import '../actions/actions.dart';

final reducers = combineReducers<AppState>([
  TypedReducer<AppState, TestAction>(_testActionReducer),
  TypedReducer<AppState, UpdateLoginDataAction>(_updateEmail),
]);

AppState _testActionReducer(AppState state, TestAction action) {
  print('${state.reduxSetup}');
  return state.copyWith(
    reduxSetup: !state.reduxSetup,
  );
}

AppState _updateEmail(AppState state, UpdateLoginDataAction action) {
  return state.copyWith(
    email: action.email,
    password: action.password,
    retypedPassword: action.retypedPassword,
  );
}