class LoginSchema {
  final bool success;
  final bool fieldMissing;
  final String apiToken;

  LoginSchema({
    this.success = false,
    this.fieldMissing = false,
    this.apiToken = "",
  });
}
