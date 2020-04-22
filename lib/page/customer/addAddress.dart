import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop/method/address.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widget/loading_widget.dart';

// 获取收货地址
// Future addUserAddress() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     var url = webApi['AddUserAddress'];
//     Map<String, dynamic> headers = new Map();
//     headers['Cookie'] = token;
//     Options options = new Options(headers: headers);
//     Response response = await Dio().post("$url", options: options);
//     print(response.data);
//     return response.data;
//   } catch (e) {
//     print(e);
//   }
// }

/// 质感设计样式
class AddMap extends StatefulWidget {
  @override
  AddMapState createState() => AddMapState();
}

class AddMapState extends State<AddMap> {
  bool isDefault = false; // 是否默认地址
  String province = ''; // 省
  String city = ''; // 市
  String area = ''; // 县

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  @override
  void initState() {
    setState(() {
      isDefault = false;
    });
    super.initState();
  }

  // 新增
  add() async {
    if(nameController.text == ''){
       Fluttertoast.showToast(
        msg: "请输入姓名",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black
      );
      return;
    }
    if(phoneController.text == ''){
       Fluttertoast.showToast(
        msg: "请输入手机号码",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black
      );
      return;
    }
    if(detailController.text == ''){
       Fluttertoast.showToast(
        msg: "请输入详细地址",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black
      );
      return;
    }
    if(province == ''){
       Fluttertoast.showToast(
        msg: "请选择地区",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black
      );
      return;
    }
    final sq = await SpUtil.getInstance();
    var userId = sq.getString("userId");
    if(userId == '') {
      Fluttertoast.showToast(
        msg: '请登陆',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black
      );
      Router.push('/login', context);
    } 
    var data= {
        'town': area,
        'city': city,
        'consignee': nameController.text,
        'specAddress': detailController.text,
        'isDefault': isDefault ? 1 : 0,
        'phone': phoneController.text,
        'province': province,
        'userId': userId
      };
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
            return new LoadingDialog( //调用对话框
                text: '提交中...',
            );
    });  
    var resultData = await addAddress(data);
      if (resultData['success']){
        Fluttertoast.showToast(
        msg: "新增成功",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.black
      );
      Router.pop(context);
      } else{
        Fluttertoast.showToast(
        msg: "新增失败",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black
      );
      Router.pop(context);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              '新增收货地址',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100])))),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('收货人'),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                            controller: nameController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                                hintText: '输入姓名', border: InputBorder.none)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('手机号码'),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                                hintText: '输入手机号码', border: InputBorder.none)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('详细地址'),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                            controller: detailController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                                hintText: '街道、楼牌号等', border: InputBorder.none)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55.0,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('所在地区'),
                      InkWell(
                        onTap: () async {
                          Result result = await CityPickers.showCityPicker(
                            context: context,
                            height: 300.0
                          );
                          print(result);
                          this.setState(() {
                            province = result.provinceName;
                            city = result.cityName;
                            area = result.areaName;
                          });
                        },
                        child: Container(
                          child: Text(
                            province == ''
                                ? '选择地区'
                                : '${this.province},${this.city},${this.area}',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('设为默认'),
                      Switch(
                          value: isDefault,
                          onChanged: (bool newValue) {
                            this.setState(() {
                              isDefault = newValue;
                            });
                          })
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                ),
                InkWell(
                  onTap: () {
                    add();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 42.0,
                    child: Text(
                      '保存地址',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ])))
        ]));
  }
}
