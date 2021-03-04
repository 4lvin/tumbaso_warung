import 'package:tumbaso_warung/src/resources/apiProvider.dart';

class Repositories {
  final apiProvider = ApiProviders();

  Future login(String username, String password) => apiProvider.login(username, password);

  Future status(String idPenjual) => apiProvider.status(idPenjual);

  Future updateStatusToko(String username, String status, String token) => apiProvider.updateStatusToko(username, status, token);

  Future getProduk(String username, String idPenjual, String token) => apiProvider.getProduk(username, idPenjual, token);

  Future updateStatusProduk(String username, String idProduk, String status, String token) =>
      apiProvider.updateStatusProduk(username, idProduk, status, token);
}
