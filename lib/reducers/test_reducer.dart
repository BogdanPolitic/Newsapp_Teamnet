import 'package:news_app/models/app_state.dart';
import 'package:redux/redux.dart';
import '../actions/actions.dart';

final reducers = combineReducers<AppState>([
  TypedReducer<AppState, TestAction>(_testActionReducer),
  TypedReducer<AppState, ByNameOrDate>(_byNameOrDate),
  TypedReducer<AppState, IncrOrDecr>(_incrOrDecr),
  TypedReducer<AppState, UpdateLoginDataAction>(_updateEmail),
  TypedReducer<AppState, ChangeChecker>(_changeChecker),
]);

AppState _byNameOrDate(AppState state, ByNameOrDate action) {
  return state.copyWith(
    switchNameOrDate: !state.switchNameOrDate,
  );
}

AppState _incrOrDecr(AppState state, IncrOrDecr action) {
  return state.copyWith(
    switchIncOrDec: !state.switchIncOrDec,
  );
}

AppState _testActionReducer(AppState state, TestAction action) {
  print('${state.reduxSetup}');
  return state.copyWith(
    reduxSetup: !state.reduxSetup,
  );
}

AppState _changeChecker(AppState state, ChangeChecker action) {
  List<bool> auxCheckers = state.getterForCheckers();
  auxCheckers[action.index] = !auxCheckers[action.index];
  return state.copyWith(
    buttonCheckers: auxCheckers,
  );
}

AppState _updateEmail(AppState state, UpdateLoginDataAction action) {
  return state.copyWith(
    email: action.email,
    password: action.password,
    retypedPassword: action.retypedPassword,
  );
}