class TestAction { }
class ByNameOrDate { }
class IncrOrDecr { }

class ChangeChecker {
  final int index;

  ChangeChecker({this.index});
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
  NavigateToHome({this.email, this.password, this.retypedPassword,});

}

class NavigateToSignIn {
  final String email;
  final String password;
  final String retypedPassword;
  NavigateToSignIn({this.email, this.password, this.retypedPassword,});
}