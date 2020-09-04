import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String username;
  @HiveField(1)
  String accountname;
  @HiveField(2)
  String poeSessionId;
  @HiveField(3)
  List<String> friends;
  @HiveField(4)
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
  }

  @override
  String toString() {
    return '$username\n$accountname\n$poeSessionId\n$disabled';
  }
}
