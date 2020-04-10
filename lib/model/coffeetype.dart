class CoffeetypeList {
  List<Coffeetype> coffeetype;

  CoffeetypeList({this.coffeetype});

  CoffeetypeList.fromJson(Map<String, dynamic> json) {
    if (json['coffeetype'] != null) {
      coffeetype = new List<Coffeetype>();
      json['coffeetype'].forEach((v) {
        coffeetype.add(new Coffeetype.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coffeetype != null) {
      data['coffeetype'] = this.coffeetype.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coffeetype {
  int iD;
  String code;
  String name;
  String image;

  Coffeetype({this.iD, this.code, this.name, this.image});

  Coffeetype.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    code = json['code'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['code'] = this.code;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}