import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:poe_currency/models/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final String tokenId = 'access_token';
  final String apiUrl = 'https://poe-currency-api.herokuapp.com';

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    final url = '$apiUrl/token';
    var map = new Map<String, dynamic>();
    var token;

    map['grant_type'] = '';
    map['client_id'] = '';
    map['client_secret'] = '';
    map['username'] = username;
    map['password'] = password;

    http.Response response = await http.post(
      url,
      body: map,
    );

    try {
      token = jsonDecode(response.body)['access_token'];
    } catch (_) {
      print(_.toString());
      return null;
    }

    return token;
  }

  Future<User> register(
      {@required String username,
      @required String password,
      @required String accountname,
      @required String poesessid}) async {
    final url = '$apiUrl/register';
    var map = new Map<String, dynamic>();
    var user;

    map['username'] = username;
    map['password'] = password;
    map['accountname'] = accountname;
    map['poesessid'] = poesessid;

    http.Response response = await http.post(
      url,
      body: map,
    );

    try {
      user = User.fromJson(jsonDecode(response.body));
      if (user.username == null) {
        return null;
      }
    } catch (_) {
      print(_.toString());
      return null;
    }

    return user;
  }

  Future<User> fetchCurrentUser() async {
    if (!await hasToken()) {
      return null;
    }

    var prefs = await _prefs;
    var token = prefs.getString(tokenId);

    final requestUrl = '$apiUrl/users/me';

    var rawData = await http
        .get(requestUrl, headers: {'Authorization': 'Bearer ' + token});

    return User.fromJson(jsonDecode(rawData.body));
  }

  Future<User> addFriend({@required String userToAdd}) async {
    if (!await hasToken()) {
      return null;
    }

    var prefs = await _prefs;
    var token = prefs.getString(tokenId);
    final url = '$apiUrl/users/me/friends/add';
    var map = new Map<String, dynamic>();
    var user;

    map['user_to_add'] = userToAdd;

    http.Response response = await http.post(
      url,
      body: map,
      headers: {'Authorization': 'Bearer ' + token}
    );

    // TODO: Should throw error instead of returning null!
    try {
      user = User.fromJson(jsonDecode(response.body));
      if (user.username == null) {
        return null;
      }
    } catch (_) {
      print(_.toString());
      return null;
    }

    return user;
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
