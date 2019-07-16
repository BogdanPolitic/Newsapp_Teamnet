import 'package:news_app/actions/actions.dart';
import 'package:news_app/models/app_state.dart';
import 'package:redux/redux.dart';

class StateViewModel {
  final List<bool> buttonCheckers;
  final bool reduxSetup;
  final bool switchIncOrDec;
  final bool switchNameOrDate;

  Function() testAction;
  Function() sortIncOrDec;
  Function() sortNameOrDate;
  Function(int index) changeCecker;
  Function(
      String email,
      String password,
      String retypedPassword,
      ) updateLoginData;
  Function(Map<String, String> loginData) navigateToHome;

  StateViewModel({
    this.sortNameOrDate,
    this.sortIncOrDec,
    this.switchIncOrDec,
    this.switchNameOrDate,
    this.buttonCheckers,
    this.reduxSetup,
    this.changeCecker,
    this.testAction,
    this.updateLoginData,
    this.navigateToHome,
  });

  factory StateViewModel.fromStore(Store<AppState> store) => StateViewModel(
    switchIncOrDec: store.state.switchIncOrDec,
    switchNameOrDate: store.state.switchNameOrDate,
    buttonCheckers: store.state.buttonCheckers,

    sortIncOrDec: () {
      store.dispatch(IncrOrDecr());
    },

    sortNameOrDate: () {
      store.dispatch(ByNameOrDate());
    },

    changeCecker: (index) {
      store.dispatch(ChangeChecker(index: index));
    },
    reduxSetup: store.state.reduxSetup,
    testAction: () {
//      print('ENTEREDDDDDDD');
      store.dispatch(TestAction());
    },
    updateLoginData: (email, password, retypedPassword) => store.dispatch(
        UpdateLoginDataAction(
            email: email,
            password: password,
            retypedPassword: retypedPassword)),
    navigateToHome: (loginData) => store.dispatch(NavigateToHome(
        email: loginData['email'], password: loginData['password'])),
  );
}