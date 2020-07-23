import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String tokenId = 'access_token';

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    final url = 'https://poe-api-proxy.herokuapp.com/token';
    var map = new Map<String, dynamic>();

    map['grant_type'] = '';
    map['client_id'] = '';
    map['client_secret'] = '';
    map['username'] = username;
    map['password'] = password;

    http.Response response = await http.post(
      url,
      body: map,
    );

    return jsonDecode(response.body)['access_token'];
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    var prefs = await _prefs;
    prefs.remove(tokenId);
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    var prefs = await _prefs;
    prefs.setString(tokenId, token);
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    var prefs = await _prefs;
    return prefs.getString(tokenId) != null;
  }
}
