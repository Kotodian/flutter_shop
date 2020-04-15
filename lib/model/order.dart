class OrderListData {
  List<OrderList> orderList;

  OrderListData({this.orderList});

  OrderListData.fromJson(Map<String, dynamic> json) {
    if (json['orderList'] != null) {
      orderList = new List<OrderList>();
      json['orderList'].forEach((v) {
        orderList.add(new OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderList != null) {
      data['orderList'] = this.orderList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  OrderList orderList;

  OrderData({this.orderList});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderList = json['orderList'] != null
        ? new OrderList.fromJson(json['orderList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderList != null) {
      data['orderList'] = this.orderList.toJson();
    }
    return data;
  }
}

class OrderList {
  int iD;
  List<OrderDetail> orderDetail;
  String orderId;
  String userId;
  String consignee;
  double value;
  String specAddress;
  int orderType;
  String phone;

  OrderList(
      {this.iD,
      this.orderDetail,
      this.orderId,
      this.userId,
      this.value,
      this.specAddress,
      this.orderType,
      this.consignee,
      this.phone});

  OrderList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    if (json['orderDetail'] != null) {
      orderDetail = new List<OrderDetail>();
      json['orderDetail'].forEach((v) {
        orderDetail.add(new OrderDetail.fromJson(v));
      });
    }
    orderId = json['orderId'];
    userId = json['userId'];
    value = json['value'];
    specAddress = json['spec_address'];
    orderType = json['orderType'];
    consignee = json['consignee'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    if (this.orderDetail != null) {
      data['orderDetail'] = this.orderDetail.map((v) => v.toJson()).toList();
    }
    data['orderId'] = this.orderId;
    data['userId'] = this.userId;
    data['value'] = this.value;
    data['spec_address'] = this.specAddress;
    data['orderType'] = this.orderType;
    data['consignee'] = this.consignee;
    data['phone'] = this.phone;
    return data;
  }
}

class OrderDetail {
  int iD;
  String orderId;
  Coffee coffee;
  String coffeeId;
  int count;
  double value;

  OrderDetail(
      {this.iD,
      this.orderId,
      this.coffee,
      this.coffeeId,
      this.count,
      this.value});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    orderId = json['orderId'];
    coffee =
        json['coffee'] != null ? new Coffee.fromJson(json['coffee']) : null;
    coffeeId = json['coffee_id'];
    count = json['count'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['orderId'] = this.orderId;
    if (this.coffee != null) {
      data['coffee'] = this.coffee.toJson();
    }
    data['coffee_id'] = this.coffeeId;
    data['count'] = this.count;
    data['value'] = this.value;
    return data;
  }
}

class Coffee {
  int iD;
  String uuid;
  String name;
  double value;
  String des;
  String img;
  String code;

  Coffee(
      {this.iD,
      this.uuid,
      this.name,
      this.value,
      this.des,
      this.img,
      this.code});

  Coffee.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uuid = json['uuid'];
    name = json['name'];
    value = json['value'];
    des = json['des'];
    img = json['img'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['value'] = this.value;
    data['des'] = this.des;
    data['img'] = this.img;
    data['code'] = this.code;
    return data;
  }
}
