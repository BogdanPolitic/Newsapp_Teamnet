import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool reduxSetup;
  final bool switchNameOrDate;
  final bool switchIncOrDec;
  final List<bool> buttonCheckers;
  final String email;
  final String password;
  final String retypedPassword;

  const AppState({
    this.switchNameOrDate,
    this.switchIncOrDec,
    this.reduxSetup,
    this.buttonCheckers,
    this.email,
    this.password,
    this.retypedPassword,
  });

  List<bool> getterForCheckers () {
    return buttonCheckers;
  }

//  const AppState.checkerChange({})

  factory AppState.initial() {
    return AppState (
      switchIncOrDec: true,
      switchNameOrDate: true,
      reduxSetup: false,
      buttonCheckers: List<bool>.filled(5, false, growable: false),
      email: '',
      password: '',
      retypedPassword: '',
    );
  }

  AppState copyWith ({
    bool switchNameOrDate,
    bool switchIncOrDec,
    bool reduxSetup,
    List<bool> buttonCheckers,
    String email,
    String password,
    String retypedPassword,
  }) {
    return AppState (
      switchNameOrDate: switchNameOrDate ?? this.switchNameOrDate,
      switchIncOrDec: switchIncOrDec ?? this.switchIncOrDec,
      reduxSetup: reduxSetup ?? this.reduxSetup,
      buttonCheckers: buttonCheckers ?? this.buttonCheckers,
      email: email ?? this.email,
      password: password ?? this.password,
      retypedPassword: retypedPassword ?? this.retypedPassword,
    );
  }

}