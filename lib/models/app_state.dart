import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool reduxSetup;
  final List<bool> buttonCheckers;
  final String email;
  final String password;
  final String retypedPassword;


  const AppState({
    this.reduxSetup,
    this.buttonCheckers,
    this.email,
    this.password,
    this.retypedPassword,
  });

  factory AppState.initial() {
    return AppState (
        reduxSetup: false,
        buttonCheckers: new List<bool>.filled(5, true, growable: false),
        email: null,
        password: null,
        retypedPassword: null,
    );
  }

  AppState copyWith ({
    bool reduxSetup,
    List<bool> buttonCheckers,
  }) {
    return AppState (
      reduxSetup: reduxSetup ?? this.reduxSetup,
      buttonCheckers: buttonCheckers ?? this.buttonCheckers,
    );
  }

}