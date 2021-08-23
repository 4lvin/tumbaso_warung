import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("tokenw", value);
}
Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("tokenw");
}
Future rmvToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("tokenw");
}

Future setKdUser(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("kduser", value);
}
Future getKdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("kduser");
}
Future rmvKdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("kduser");
}

Future setNama(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("nama", value);
}
Future getNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("nama");
}
Future rmvNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("nama");
}

Future setEmail(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("email", value);
}
Future getEmail() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("email");
}
Future rmvEmail() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("email");
}

Future setKdPasmak(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("kdpenjualpasmak", value);
}
Future getKdPasmak() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("kdpenjualpasmak");
}
Future rmvKdPasmak() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("kdpenjualpasmak");
}