import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Authentication {
  bool loginok = false;
  Map datos = {};
  String token = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> fetchCredentials(String username, String password) async {
    final String contras = sha1.convert(utf8.encode(password)).toString();
    var url = Uri.https('app.lasei.es', '/app.php', {
      'eml': username,
      'passw': contras, //sha1.convert(convert.utf8.encode(password)),
      'tok': token,
    });
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    final SharedPreferences prefs = await _prefs;

    if (response.statusCode == 200) {
      datos = convert.jsonDecode(response.body);
      //print(jsonResponse);
      loginok = datos['resultado'] == 1;
      if (loginok) {
        prefs.setString('usuario', username);
        prefs.setString('contras', password);
      }
    }
  }
}

final auth = Authentication();
