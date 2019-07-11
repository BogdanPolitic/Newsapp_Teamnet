class TestAction {
  bool testPayload;

  TestAction(this.testPayload) {
    testPayload = !testPayload;
  }
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