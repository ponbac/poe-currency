import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:poe_currency/models/user/user.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  UserRepository() {
    
  }

  final String boxName = 'mainBox';
  final String tokenId = 'access_token';
  final String currentUserId = 'current_user';
  final String apiUrl = 'https://poe-currency-api.herokuapp.com';

  Future<Box> getOpenBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      Hive.registerAdapter(UserAdapter());
      return await Hive.openBox(boxName);
    }

    return Hive.box(boxName);
  }

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

  void deleteToken() async {
    /// delete from keystore/keychain
    var box = await getOpenBox();
    box.delete(tokenId);
  }

  void persistToken(String token) async {
    /// write to keystore/keychain
    var box = await getOpenBox();
    box.put(tokenId, token);
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    var box = await getOpenBox();
    return await box.get(tokenId) != null;
  }

  Future<User> fetchCurrentUser() async {
    if (!await hasToken()) {
      return null;
    }
    var box = await getOpenBox();
    var token = await box.get(tokenId);

    final requestUrl = '$apiUrl/users/me';

    var rawData = await http
        .get(requestUrl, headers: {'Authorization': 'Bearer ' + token});

    // update stored user object
    User currentUser = User.fromJson(jsonDecode(rawData.body));
    persistUser(currentUser);

    return currentUser;
  }

  Future<User> addFriend({@required String userToAdd}) async {
    if (!await hasToken()) {
      return null;
    }

    var box = await getOpenBox();
    var token = await box.get(tokenId);
    final url = '$apiUrl/users/me/friends/add';
    var map = new Map<String, dynamic>();
    var user;

    map['user_to_add'] = userToAdd;

    http.Response response = await http
        .post(url, body: map, headers: {'Authorization': 'Bearer ' + token});

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

  void deleteUser() async {
    /// delete from keystore/keychain
    var box = await getOpenBox();
    box.delete(currentUserId);
  }

  void persistUser(User user) async {
    var box = await getOpenBox();
    box.put(currentUserId, user);
  }

  Future<bool> hasUser() async {
    /// read from keystore/keychain
    var box = await getOpenBox();
    return await box.get(currentUserId) != null;
  }
}
