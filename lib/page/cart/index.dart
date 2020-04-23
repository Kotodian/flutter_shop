import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop/method/cart.dart';
import 'package:flutter_shop/model/cartInfo.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/utils/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';


/// 质感设计样式
class CartPage extends StatefulWidget {
  const CartPage();
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  

  
  // 是否正在请求
  bool loading = false;
  // 购物车列表
  List<CartInfo> list = [];
  // 合计
  double total = 0.0;

  // 是否正在编辑
  bool isEdit = false;

  Future getCustomerCart() async {
    final sq = await SpUtil.getInstance();
    if(sq.getString('token') != '') {
    var data = await getCartList();
    if(data['data']['msg'] == '授权已过期')
    {
      ToastUtils.showToast('授权已过期,请重新登录');
      Router.push('/login', context);
    }
    print(data);
    if(mounted) {
      setState(() {
        data['data']['cartList'].forEach((item){
        list.add(CartInfo.fromJson(item));
        total += item['value'];
      });
      loading = true;
    });
  }
}else {
  ToastUtils.showToast("请先登录");
  Router.push('/login', context);
}
}

  @override
  void initState() {
    super.initState();
    getCustomerCart();
  }

// 修改购物车状态
  Future checkStatus(item, status) async {
    try {
      var data = {
        "id": item.id,
        "isCheck": item.isCheck
      };
      var response = await checkCartStatus(data);
      item.isCheck = status;
      double totals = 0;
      totals += item.value;
      if (status == 1) {
        total += totals;
      } else {
        total -= totals;
      }
      if(mounted) {
      this.setState(() {
        list = list;
        total = total;
      });
      }

      return response['data'];
    } catch (e) {
      print(e);
    }
  }

  // // 是否还有库存
  // bool isStock(item) {
  //   var flag = true;
  //   if (item.attrList.id == 0) {
  //     flag = item.productStock > 0;
  //   } else {
  //     flag = int.parse(item.attrList.productStock) > 0;
  //   }
  //   return flag;
  // }

  // 显示的价格
  // String showPrice(CartInfo item) {
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
    if (loading) {
      list.map((item) {
        itemList.add(
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            margin: EdgeInsets.only(bottom: 20.0, right: 8.0),
            child: Dismissible(
              direction: DismissDirection.endToStart,
              key: new Key(item.id.toString()),
              secondaryBackground: Container(
                color: Colors.red,
                padding: EdgeInsets.only(right: 20.0),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
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
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('提示${item.id.toString()}'),
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
                        );
                      });
                }
              },
              child: Row(
                children: <Widget>[
                      Stack(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                child: item.isCheck == 1
                                    ? Icon(
                                        Icons.check,
                                        size: 18.0,
                                        color: Colors.white,
                                      )
                                    : Container(),
                                margin: EdgeInsets.only(left: 10.0),
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                    color: item.isCheck == 1
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                        color: item.isCheck == 1
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[350]),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)))),
                            Opacity(
                              opacity: 0,
                              child: Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                value: item.isCheck == 1 ? true : false,
                                onChanged: (bool value) {
                                  checkStatus(item, value ? 1 : 0);
                                },
                              ),
                            )
                          ],
                        ),
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
                            margin: EdgeInsets.only(
                              left: 5.0
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(item.coffee.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16.0)),
                                Text(item.spec,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16.0)),                                    
                                // item.attrList.specs != ''
                                //     ? Container(
                                //         decoration: BoxDecoration(
                                //             color: Colors.grey[200],
                                //             borderRadius: BorderRadius.all(
                                //                 Radius.circular(10.0))),
                                //         margin: EdgeInsets.only(
                                //             top: 5.0, bottom: 5.0),
                                //         padding: EdgeInsets.only(
                                //             left: 5.0,
                                //             right: 5.0,
                                //             top: 3.0,
                                //             bottom: 3.0),
                                //         child: Text(
                                //           item.attrList.specs,
                                //           style: TextStyle(
                                //               color: Colors.grey[500]),
                                //           maxLines: 2,
                                //         ),
                                //       )
                                //     : Container(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "￥" + item.value.toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 22.0),
                                    ),
                                    isEdit
                                        ? Container(
                                            child: Row(
                                              children: <Widget>[
                                                Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      item.count++;
                                                      addCart(item.coffeeId,item.spec,item.value);
                                                      item.value += item.value;
                                                      this.setState(() {
                                                        list = this.list;
                                                        total = total + item.value;
                                                      });
                                                    },
                                                    splashColor: Colors.grey
                                                        .withOpacity(0.3),
                                                    highlightColor: Colors.grey
                                                        .withOpacity(0.1),
                                                    child: Container(
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 14.0,
                                                        ),
                                                        height: 32.0,
                                                        width: 10.0),
                                                  ),
                                                ),
                                                Container(
                                                  width: 50.0,
                                                  child: Text(
                                                    item.count
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (item.count >
                                                          1) {
                                                        item.count--;
                                                        item.value -= item.value;
                                                        reduceCart(item.coffeeId,item.spec);
                                                        this.setState(() {
                                                          list = this.list;
                                                          total = total - item.value;
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 14.0,
                                                        ),
                                                        height: 32.0,
                                                        width: 10.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Text("x" +
                                            item.count.toString(), style: TextStyle(fontSize: 14.0, color: Colors
                                            .grey),),
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
          ),
        );
      }).toList();
    }
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
              '购物车',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              Align(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      this.setState(() {
                        isEdit = !this.isEdit;
                      });
                    },
                    child: isEdit ? Text("完成") : Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(loading
                      ? listUI()
                      : <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: SizedBox(
                                width: 30.0,
                                height: 30.0,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        ])))
        ]),
        bottomNavigationBar: loading
            ? Container(
                height: 44.0,
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text('合计：'),
                          Text(
                            '￥${total.toStringAsFixed(2).toString()}',
                            style: TextStyle(color: Colors.red, fontSize: 22.0),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Router.push("/confirmOrder",context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        margin: EdgeInsets.only(left: 15.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Text('去结算',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 0.0,
              ));
    }
  }
