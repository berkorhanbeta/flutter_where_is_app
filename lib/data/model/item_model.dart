class ItemModel {

  int? _id;
  String? _icon;
  String? _name;
  String? _hint;
  String? _address;
  double? _lat;
  double? _long;

  ItemModel(
      int? id,
      String? icon,
      String? name,
      String? hint,
      String? address,
      double? lat,
      double? long
      ){
    _id = id;
    _icon = icon;
    _name = name;
    _hint = hint;
    _address = address;
    _lat = lat;
    _long = long;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = _id;
    data['icon'] = _icon;
    data['name'] = _name;
    data['hint'] = _hint;
    data['address'] = _address;
    data['lat'] = _lat;
    data['long'] = _long;
    return data;
  }

  ItemModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _icon = json['icon'];
    _name = json['name'];
    _hint = json['hint'];
    _address = json['address'];
    _lat = json['lat'];
    _long = json['long'];
  }

  int? get id => _id;
  String? get icon => _icon;
  String? get name => _name;
  String? get hint => _hint;
  String? get address => _address;
  double? get lat => _lat;
  double? get long => _long;

  set id(nId) => _id = nId;

}

