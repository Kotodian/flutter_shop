class Customer {
  int iD;
  String uuid;
  String username;
  String password;
  String nickname;
  String email;
  String phone;
  String image;

  Customer(
      {this.iD,
      this.uuid,
      this.username,
      this.password,
      this.nickname,
      this.email,
      this.phone,
      this.image
  });

  Customer.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uuid = json['uuid'];
    username = json['username'];
    password = json['password'];
    nickname = json['nickname'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['password'] = this.password;
    data['nickname'] = this.nickname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    return data;
  }
}