import 'package:meta/meta.dart';

class User {
  String username;
  String accountname;
  String poeSessionId;
  bool disabled;

  User({@required this.username, @required this.accountname, @required this.poeSessionId, this.disabled});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    accountname = json['accountname'];
    poeSessionId = json['poesessid'];
    disabled = json['disabled'];
  }

  @override
  String toString() {
    return '$username\n$accountname\n$poeSessionId\n$disabled';
  }
}
