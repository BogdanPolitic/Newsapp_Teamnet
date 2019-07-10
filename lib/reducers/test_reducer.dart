// lib/reducers/test_reducer.dart
import 'package:redux/redux.dart';
import 'package:Newsapp_Teamnet/actions/actions.dart';

final testReducer = TypedReducer<bool, TestAction>(_testActionReducer);

bool _testActionReducer(bool state, TestAction action) {
  return action.testPayload;
}