class TestAction {
  bool testPayload;

  TestAction(this.testPayload) {
    testPayload = !testPayload;
  }
}