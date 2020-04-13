class Address {
  int id;
  String userId;
  String province;
  String city;
  String town;
  String specAddress;
  String phone;
  int isDefault;
  String consignee;
  Address(
      {this.id,
      this.userId,
      this.province,
      this.city,
      this.town,
      this.specAddress,
      this.phone,
      this.isDefault,
      this.consignee});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    userId = json['userId'];
    province = json['province'];
    city = json['city'];
    town = json['town'];
    specAddress = json['specAddress'];
    phone = json['phone'];
    isDefault = json['isDefault'];
    consignee = json['consignee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['userId'] = this.userId;
    data['province'] = this.province;
    data['city'] = this.city;
    data['town'] = this.town;
    data['specAddress'] = this.specAddress;
    data['phone'] = this.phone;
    data['isDefault'] = this.isDefault;
    data['consignee'] = this.consignee;
    return data;
  }
}