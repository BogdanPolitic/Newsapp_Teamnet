import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool reduxSetup;
  final List<bool> buttonCheckers;
//  final

  const AppState({
    this.reduxSetup,
    this.buttonCheckers,
  });

  factory AppState.initial() {
    return AppState (
        reduxSetup: false,
        buttonCheckers: List<bool>.filled(5, false, growable: false),
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