/*import 'actions/actions.dart';

class AppState {
  String email;
  String password;
  String retypedPassword;
  AppState(this.email, this.password, this.retypedPassword);
}

class UpdateEmail {
  String value;
  UpdateEmail(this.value);
}
class UpdatePassword {
  String value;
  UpdatePassword(this.value);
}
class UpdateRetypedPassword {
  String value;
  UpdateRetypedPassword(this.value);
}

AppState reducer(AppState prev, dynamic action) {
  if (action is UpdateEmail) {
    return AppState(action.value, prev.password, prev.retypedPassword);
  } else if (action is UpdatePassword) {
    return AppState(prev.email, action.value, prev.retypedPassword);
  } else if (action is UpdateRetypedPassword) {
    return AppState(prev.email, prev.password, action.value);
  } else {
    return null;
  }
}*/