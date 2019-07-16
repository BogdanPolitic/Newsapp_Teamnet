import 'package:news_app/models/app_state.dart';

import '../reducers/test_reducer.dart';
AppState appReducer(AppState state, dynamic action) {

  return reducers(state, action);

}