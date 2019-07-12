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

//  const AppState.checkerChange({})

  factory AppState.initial() {
    return AppState (
        reduxSetup: false,
        buttonCheckers: List<bool>.filled(5, false, growable: false),
        email: '',
        password: '',
        retypedPassword: '',
    );
  }

  AppState copyWith ({
    bool reduxSetup,
    List<bool> buttonCheckers,
    String email,
    String password,
    String retypedPassword,
  }) {
    return AppState (
      reduxSetup: reduxSetup ?? this.reduxSetup,
      buttonCheckers: buttonCheckers ?? this.buttonCheckers,
      email: email ?? this.email,
      password: password ?? this.password,
      retypedPassword: retypedPassword ?? this.retypedPassword,
    );
  }

}