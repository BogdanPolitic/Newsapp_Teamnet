// lib/reducers/app_reducer.dart
import 'package:Newsapp_Teamnet/models/models.dart';
import 'package:Newsapp_Teamnet/reducers/test_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    reduxSetup: testReducer(state.reduxSetup, action),
  );
}