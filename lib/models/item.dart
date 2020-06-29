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
  List<String> explicitMods;
  String descrText;
  int frameType;
  int stackSize;
  int maxStackSize;
  int x;
  int y;
  String inventoryId;

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
      this.explicitMods,
      this.descrText,
      this.frameType,
      this.stackSize,
      this.maxStackSize,
      this.x,
      this.y,
      this.inventoryId});

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
    explicitMods = json['explicitMods'] == null ? [''] : json['explicitMods'].cast<String>();
    descrText = json['descrText'];
    frameType = json['frameType'];
    stackSize = json['stackSize'];
    maxStackSize = json['maxStackSize'];
    x = json['x'];
    y = json['y'];
    inventoryId = json['inventoryId'];
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
    data['explicitMods'] = this.explicitMods;
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
        return 'Name: $typeLine, amount: $stackSize';
    }
}
