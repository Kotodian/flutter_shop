import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop/method/address.dart';
import 'package:flutter_shop/method/cart.dart';
import 'package:flutter_shop/method/order.dart';
import 'package:flutter_shop/model/address.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_shop/utils/fluttertoast.dart';




// 获取商品清单
// Future getCartList() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     var url = webApi['CartSelectList'];
//     Map<String, dynamic> headers = new Map();
//     headers['Cookie'] = token;
//     Options options = new Options(headers: headers);
//     Response response = await Dio().get("$url", options: options);
//     print(response.data);
//     return response.data;
//   } catch (e) {
//     print(e);
//   }
// }

/// 质感设计样式
class OrderPage extends StatefulWidget {
  const OrderPage();
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {

  // 个人收货地址列表
  List<Address> addressList = [];

  // 选择的收货地址
  Address currentAddress;

  // 商品清单
  List<CartInfo> cartList = [];

  // 商品总价
  double total = 0;
// 获取客户地址
Future getUserAddress() async {
  final sq = await SpUtil.getInstance();
  var userId = sq.getString("userId");
  var data = {
    "pageInfo": {
		"page": 1,
		"pageSize": 999
	},
	"user_id": userId
  };
  var response = await getAddressList(data);
  print(response);
  response['data']['addressList'].forEach((item){
  addressList.add(Address.fromJson(item));
    if(item['isDefault'] == 1) {
      setState(() {
        print(currentAddress);
        currentAddress = Address.fromJson(item);
      });
    }
    });  
}

changeCurrentAddress(onValue) {
  setState(() {
    currentAddress = onValue;
  });
}
// 获取用户购物车
Future getUserCart() async {
    var data = await getCartList();
    //print(data);
    this.setState(() {
      data['data']['cartList'].forEach((item){
        if(item['isCheck'] == 1) {
          cartList.add(CartInfo.fromJson(item));
          total += item['value'];
        }
      });
    });  
}
  @override
  void initState() {
    super.initState();
    getUserAddress();
    getUserCart();
  }

// 显示的价格
  // String showPrice(CartData item) {
  //   var price = '';
  //   if (item.attrList.id == 0) {
  //     price = item.productPrice.toString();
  //   } else {
  //     price = item.attrList.productPrice;
  //   }
  //   return price;
  // }

  listUI() {
    List<Widget> itemList = [];
    cartList.map((item) {
      itemList.add(
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[100]))),
          margin: EdgeInsets.only(bottom: 20.0, right: 8.0,left: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      child: CachedNetworkImage(
                        width: 100.0,
                        height: 100.0,
                        imageUrl: item.coffee.img,
                        placeholder: (context, url) => new Icon(
                          Icons.image,
                          color: Colors.grey[300],
                          size: 100.0,
                        ),
                        errorWidget: (context, url, error) => new Icon(
                          Icons.image,
                          color: Colors.grey[300],
                          size: 100.0,
                        ),
                      ),
                      width: 100.0,
                      height: 100.0,
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(item.coffee.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18.0)),
                            // item.attrList.specs != ''
                            //     ? Container(
                            //         decoration: BoxDecoration(
                            //             color: Colors.grey[200],
                            //             borderRadius: BorderRadius.all(
                            //                 Radius.circular(10.0))),
                            //         margin:
                            //             EdgeInsets.only(top: 5.0, bottom: 5.0),
                            //         padding: EdgeInsets.only(
                            //             left: 5.0,
                            //             right: 5.0,
                            //             top: 3.0,
                            //             bottom: 3.0),
                            //         child: Text(
                            //           item.attrList.specs,
                            //           style: TextStyle(color: Colors.grey[500]),
                            //           maxLines: 2,
                            //         ),
                            //       )
                            //     : Container(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "￥" + item.value.toStringAsFixed(2),
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 22.0),
                                ),
                                Text("x" + item.count.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          elevation: 1.0,
          title: Text(
            '确认订单',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[],
        ),
        SliverPadding(
            padding: const EdgeInsets.all(0.0),
            sliver: new SliverList(
                delegate: new SliverChildListDelegate(<Widget>[
              Container(
                height: 2.0,
                color: Colors.grey[200],
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Router.push("/orderMap",context,null,(onValue){
                      setState(() {
                        currentAddress = onValue;
                      });
                    });
                    // Navigator.of(context).pushNamed('/oderMap').then((onValue){
                    //   setState(() {
                    //     currentAddress = onValue;
                    //   });
                    // });
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.room),
                        currentAddress != null
                            ? Expanded(child: Container(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      currentAddress.specAddress,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Container(
                                      height: 10.0,
                                    ),
                                    Text(currentAddress.consignee + ' '+
                                            currentAddress.phone,
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.grey))
                                  ],
                                ),
                              ),)
                            : Text('添加收货地址'),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 10.0,
                color: Colors.grey[200],
              ),
              Container(
                child: Text('商品清单'),
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey[300]))),
              ),
              Column(
                children: listUI(),
              ),
              Container(
                height: 10.0,
                color: Colors.grey[200],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('商品总额',style: TextStyle(fontSize: 16.0),),
                      Text('￥${total.toStringAsFixed(2)}',style: TextStyle(fontSize: 16.0,color: Colors.red),),
                    ],
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('配送费',style: TextStyle(fontSize: 16.0),),
                      Text('￥0',style: TextStyle(fontSize: 16.0,color: Colors.red),),
                    ],
                  ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('实付款',style: TextStyle(fontSize: 16.0),),
                      Text('￥${total.toStringAsFixed(2)}',style: TextStyle(fontSize: 16.0,color: Colors.red),),
                    ],
                  ),
                  )
                  
                ],
              )
            ])))
      ]),
      bottomNavigationBar:Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 40,
        height: 42.0,
        child: Column(
          children: <Widget>[
            GestureDetector(
            onTap: () async{
              var data = {
            'cartList': cartList,
            'consignee': currentAddress.consignee,
            'spec_address': currentAddress.specAddress,
            'orderType': 2,
            'phone': currentAddress.phone
          };
           var response = await addUserOrder(data);
            ToastUtils.showToast("支付成功");
            Router.push('/orderDetail', context);
            Router.push('/orderDetail', context,{'orderId': response['data']['order_id']});
            },
            child: Text(
            '确认支付',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            )
          ],
        )
      ),
    );
  }
}
