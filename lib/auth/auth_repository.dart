class AuthRepository {
  Future<void> login() async {
    print('attemting login');
    await Future.delayed(Duration(seconds: 3));
    print('logged in ');
    throw Exception('failed login');
  }

  attemptAutoLogin() {}
}
