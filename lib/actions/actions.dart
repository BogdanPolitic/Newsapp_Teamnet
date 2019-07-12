class TestAction {

}

class ChangeFilterCheckers {
  int checkerVal;

  ChangeFilterCheckers(int checkerNewVal, List<bool> myButtons) {
    checkerVal = checkerNewVal;
    myButtons[checkerNewVal];
  }
}

class UpdateLoginDataAction {
  final String email;
  final String password;
  final String retypedPassword;
  UpdateLoginDataAction({this.email, this.password, this.retypedPassword,});
}

class NavigateToHome {
  final String email;
  final String password;
  final String retypedPassword;
  NavigateToHome({this.email, this.password, this.retypedPassword,});}