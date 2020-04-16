class CartInfo {
  int id;
  Coffee coffee;
  String coffeeId;
  String spec;
  double value;
  int count;
  String userId;
  int isCheck;

  CartInfo(
      {this.id,
      this.coffee,
      this.coffeeId,
      this.value,
      this.count,
      this.userId,
      this.isCheck,
      this.spec});

  CartInfo.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    coffee =
        json['coffee'] != null ? new Coffee.fromJson(json['coffee']) : null;
    coffeeId = json['coffee_id'];
    value = json['value'];
    count = json['count'];
    userId = json['user_id'];
    isCheck = json['isCheck'];
    spec = json['spec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    if (this.coffee != null) {
      data['coffee'] = this.coffee.toJson();
    }
    data['coffee_id'] = this.coffeeId;
    data['value'] = this.value;
    data['count'] = this.count;
    data['user_id'] = this.userId;
    data['isCheck'] = this.isCheck;
    data['spec'] = this.spec;
    return data;
  }
}

class Coffee {
  int id;
  String uuid;
  String name;
  double value;
  String des;
  String img;
  Type type;
  String code;
  List<Spec> spec;

  Coffee(
      {this.id,
      this.uuid,
      this.name,
      this.value,
      this.des,
      this.img,
      this.type,
      this.code,
      this.spec});

  Coffee.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    uuid = json['uuid'];
    name = json['name'];
    value = json['value'];
    des = json['des'];
    img = json['img'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    code = json['code'];
    if (json['spec'] != null) {
      spec = new List<Spec>();
      json['spec'].forEach((v) {
        spec.add(new Spec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['value'] = this.value;
    data['des'] = this.des;
    data['img'] = this.img;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    data['code'] = this.code;
    if (this.spec != null) {
      data['spec'] = this.spec.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Type {
  int id;
  String code;
  String name;
  String image;

  Type({this.id, this.code, this.name, this.image});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    code = json['code'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class Spec {
  int id;
  String uuid;
  String name;
  String sort;

  Spec({this.id, this.uuid, this.name, this.sort});

  Spec.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    uuid = json['uuid'];
    name = json['name'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['sort'] = this.sort;
    return data;
  }
}