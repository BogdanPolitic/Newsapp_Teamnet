// lib/reducers/app_reducer.dart
import 'package:news_app/models/models.dart';
import 'package:news_app/reducers/test_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    reduxSetup: testReducer(state.reduxSetup, action),
  );
}