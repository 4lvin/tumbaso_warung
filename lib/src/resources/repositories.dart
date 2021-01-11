import 'package:tumbaso_warung/src/resources/apiProvider.dart';

class Repositories {
  final apiProvider = ApiProviders();

  Future login(String username, String password) =>
      apiProvider.login(username, password);
}