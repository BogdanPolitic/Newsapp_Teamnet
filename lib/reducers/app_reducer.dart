// lib/reducers/app_reducer.dart
import '../models/models.dart';
import '../reducers/test_reducer.dart';
import '../actions/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is TestAction)
    return AppState(reduxSetup: testReducer(state.reduxSetup, action),);
  else if (action is UpdateEmail) {
    return AppState(email: action.value, password: state.password, retypedPassword: state.retypedPassword);
  } else if (action is UpdatePassword) {
    return AppState(email: state.email, password: action.value, retypedPassword: state.retypedPassword);
  } else if (action is UpdateRetypedPassword) {
    return AppState(email: state.email, password: state.password, retypedPassword: action.value);
  } else {
    return null;
  }
}