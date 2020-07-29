import 'package:meta/meta.dart';

class Snapshot {
  String username;
  int value;
  DateTime date;

  Snapshot({@required this.username, @required this.value, @required this.date});

  Snapshot.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    value = json['value'];
    date = DateTime.parse(json['date']).toLocal();
  }

  @override
  String toString() {
    return '$username\n$value\n$date';
  }
}
