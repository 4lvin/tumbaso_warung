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

Future setUsername(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("username", value);
}
Future getUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("username");
}
Future rmvUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("username");
}