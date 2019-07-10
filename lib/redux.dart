class AppState {
  String _email;
  String _password;
  String _retypedPassword;
  AppState(this._email, this._password, this._retypedPassword);
}

class Action {
  String action;
  String value;
  Action(this.action, this.value);
}

enum Actions {
  update_email,
  update_password,
  update_retypedPassword
}

AppState reducer(AppState prev, action) {
  switch (action.action) {
    case Actions.update_email:
      return AppState(action.value, prev._password, prev._retypedPassword);
    case Actions.update_password:
      return AppState(prev._email, action.value, prev._retypedPassword);
    case Actions.update_retypedPassword:
      return AppState(prev._email, prev._password, action.value);
    default:
      return null;
  }
}