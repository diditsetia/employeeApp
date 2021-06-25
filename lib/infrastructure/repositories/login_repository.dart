abstract class LoginRepository {
  Future login(
    String email,
    String password,
  );

  Future checklogin();
}
