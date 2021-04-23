import 'dart:math';

class Item {
  bool verified;
  int w;
  int h;
  String icon;
  String league;
  String id;
  String name;
  String typeLine;
  bool identified;
  int ilvl;
  int level;
  List<String> implicitMods;
  List<String> explicitMods;
  List<Socket> sockets;
  String descrText;
  int frameType;
  int stackSize;
  int maxStackSize;
  int x;
  int y;
  String inventoryId;
  List<String> tabs = [];
  double value;

  Item(
      {this.verified,
      this.w,
      this.h,
      this.icon,
      this.league,
      this.id,
      this.name,
      this.typeLine,
      this.identified,
      this.ilvl,
      this.level,
      this.implicitMods,
      this.explicitMods,
      this.sockets,
      this.descrText,
      this.frameType,
      this.stackSize,
      this.maxStackSize,
      this.x,
      this.y,
      this.inventoryId,
      this.tabs,
      this.value});

  int get socketLinks {
    if (sockets == null) {
      return 0;
    }

    List<int> socketGroups = [0, 0, 0, 0, 0, 0];

    sockets.forEach((s) {
      socketGroups[s.group]++;
    });

    return socketGroups.reduce(max);
  }

  double get totalValue {
    return (value ?? 0.0) * (stackSize ?? 1);
  }

  Item.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    w = json['w'];
    h = json['h'];
    icon = json['icon'];
    league = json['league'];
    id = json['id'];
    name = json['name'];
    typeLine = json['typeLine'];
    identified = json['identified'];
    ilvl = json['ilvl'];
    implicitMods = json['implicitMods'] == null
        ? ['']
        : json['implicitMods'].cast<String>();
    explicitMods = json['explicitMods'] == null
        ? ['']
        : json['explicitMods'].cast<String>();
    if (json['sockets'] != null) {
      sockets = [];
      json['sockets'].forEach((s) {
        sockets.add(new Socket.fromJson(s));
      });
    }
    descrText = json['descrText'];
    frameType = json['frameType'];
    stackSize = json['stackSize'];
    maxStackSize = json['maxStackSize'];
    x = json['x'];
    y = json['y'];
    inventoryId = json['inventoryId'];

    // TODO: THIS DOES NOT WORK!
    /*try {
      level = int.parse(json['properties']['values'][0][0]);
      print('Level of $typeLine: $level');
    } catch (_) {
      print(_.toString());
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['w'] = this.w;
    data['h'] = this.h;
    data['icon'] = this.icon;
    data['league'] = this.league;
    data['id'] = this.id;
    data['name'] = this.name;
    data['typeLine'] = this.typeLine;
    data['identified'] = this.identified;
    data['ilvl'] = this.ilvl;
    data['implicitMods'] = this.implicitMods;
    data['explicitMods'] = this.explicitMods;
    data['sockets'] = this.sockets;
    data['descrText'] = this.descrText;
    data['frameType'] = this.frameType;
    data['stackSize'] = this.stackSize;
    data['maxStackSize'] = this.maxStackSize;
    data['x'] = this.x;
    data['y'] = this.y;
    data['inventoryId'] = this.inventoryId;
    return data;
  }

  @override
  String toString() {
    return '$typeLine, amount: $stackSize';
  }
}

class Socket {
  int group;
  String attr;
  String sColour;

  Socket({this.group, this.attr, this.sColour});

  Socket.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    attr = json['attr'];
    sColour = json['sColour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['attr'] = this.attr;
    data['sColour'] = this.sColour;
    return data;
  }
}
