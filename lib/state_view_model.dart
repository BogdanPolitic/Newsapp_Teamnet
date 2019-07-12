import 'package:newsapp/actions/actions.dart';
import 'package:newsapp/models/app_state.dart';
import 'package:redux/redux.dart';

class StateViewModel {
  final List<bool> buttonCheckers;
  final bool reduxSetup;
  Function() testAction;
  Function(String email, String password, String retypedPassword,) updateLoginData;
  Function(Map<String, String> loginData) navigateToHome;

  StateViewModel({this.buttonCheckers, this.reduxSetup, this.testAction, this.updateLoginData, this.navigateToHome,}) {
    print('aiciaici');
  }

  factory StateViewModel.fromStore(Store<AppState> store) => StateViewModel(
    buttonCheckers: store.state.buttonCheckers,
    reduxSetup: store.state.reduxSetup,
    testAction: () {
      print('ENTEREDDDDDDD');
      store.dispatch(TestAction());
      },
    updateLoginData: (email, password, retypedPassword) => store.dispatch(UpdateLoginDataAction(
      email: email,
      password: password,
      retypedPassword: retypedPassword
    )),
    navigateToHome: (loginData) => store.dispatch(NavigateToHome(email: loginData['email'], password: loginData['password'])),
  );
}