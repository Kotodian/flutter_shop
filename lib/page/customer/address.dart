import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop/method/address.dart';
import 'package:flutter_shop/model/address.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/utils/fluttertoast.dart';





/// 质感设计样式
class OrderMap extends StatefulWidget {
  @override
  OrderMapState createState() => OrderMapState();
}

class OrderMapState extends State<OrderMap> {

  // 个人收货地址列表
  List<Address> addressList = [];
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
  if(response['success']) {
      this.setState(() {
        response['data']['addressList'].forEach((item){
        addressList.add(Address.fromJson(item));
      });
    });
    ToastUtils.showToast(response['msg']);
  }else {
    ToastUtils.showToast('获取地址失败,请添加地址');
  }

}
  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  listUI() {
    List<Widget> itemList = [];
    addressList.map((item) {
      itemList.add(
        Dismissible(
          direction: DismissDirection.endToStart,
          key: new Key(item.id.toString()),
          secondaryBackground: Container(
            color: Colors.red,
            padding: EdgeInsets.only(right: 20.0),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete,color: Colors.white,),
          ),
           background: Container(
            alignment: Alignment.centerRight,
            color: Colors.green,
            child: Icon(Icons.delete),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart) {
              showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('提示'),
                    content: Text("确定删除？"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text('取消'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      new FlatButton(
                        child: new Text('确定'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            padding:
                EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.consignee,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          Text(item.phone,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey)),
                          item.isDefault == 1
                              ? Container(
                                  margin: EdgeInsets.only(left: 3.0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('默认',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white)),
                                )
                              : Container()
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(item.specAddress,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey))
                    ],
                  ),
                ),
                Icon(Icons.edit)
              ],
            ),
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
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              '收货地址',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              Align(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      Router.push('/addMap', context);
                    },
                    child: Text(
                      '新增地址',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(listUI())))
        ]));
  }
}
