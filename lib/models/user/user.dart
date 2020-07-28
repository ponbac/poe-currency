import 'package:meta/meta.dart';

class User {
  String username;
  String accountname;
  String poeSessionId;
  List<String> friends;
  bool disabled;

  User({@required this.username, this.accountname, this.poeSessionId, this.friends, this.disabled});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    accountname = json['accountname'];
    poeSessionId = json['poesessid'];
    friends = json['friends'] == null
        ? ['']
        : json['friends'].cast<String>();
    disabled = json['disabled'];

    print('$friends');
  }

  @override
  String toString() {
    return '$username\n$accountname\n$poeSessionId\n$disabled';
  }
}
