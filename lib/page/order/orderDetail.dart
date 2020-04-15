import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_shop/method/order.dart';
import 'package:flutter_shop/model/order.dart';
import 'package:cached_network_image/cached_network_image.dart';

// 获取订单详情
Future getOrderDetail(String id) async {
  var data = {
    "orderId": id
  };
  var response = await getUserOrderDetail(data);
  return response['data'];
}

// 订单状态
String orderStatus(int status) {
  if (status == 1) {
    return '待付款';
  } else if (status == 2) {
    return '已完成';
  } else if (status == 3) {
    return '已取消';
  }
}

/// 质感设计样式
class OrderDetailPage extends StatefulWidget {
  final Map arguments;
  const OrderDetailPage({this.arguments});

  @override
  OrderDetailPageState createState() => OrderDetailPageState();
}

class OrderDetailPageState extends State<OrderDetailPage> {
  // OrderDetailPageState(this.id);

  // 商品id
  String id;

  // 订单数据
  OrderData orderDetail;

  // 是否正在加载
  bool loading = false;


  @override
  void initState() {
    super.initState();
    OrderData resultData;
    this.id = widget.arguments['orderId'];
    print(this.id);
    getOrderDetail(this.id).then((data) {
      try {
        resultData = OrderData.fromJson(data);
        loading = true;
      } catch (err) {
        // print("解析错误");
        // loading = false;
        // Common addCart = Common.fromJson(data);
        // showDialog(
        //     context: context,
        //     child: AlertDialog(
        //       title: Text('提示'),
        //       content: Text(addCart.msg == null ? '' : addCart.msg),
        //       actions: <Widget>[
        //         new FlatButton(
        //           child: new Text('确定'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //             Application.router.navigateTo(context, "/login");
        //           },
        //         ),
        //       ],
        //     ));
        print(err);
        return;
      }
      print(resultData);
      setState(() {
        orderDetail = resultData;
        loading = loading;
      });
    });
  }

  // 订单列表布局
  Widget orderListUI(OrderList order, BuildContext context) {
    List<Widget> child = [];
    for (var i = 0; i < order.orderDetail.length; i++) {
      var item = order.orderDetail[i];
      child.add(Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {},
                child: Row(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: item.coffee.img,
                      width: 100.0,
                      height: 100.0,
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
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.coffee.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0
                              ),
                            //   child: Text(
                            //   order.productSpecsList[i].id > 0
                            //       ? order.productSpecsList[i].specs
                            //       : '',
                            //   maxLines: 2,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: TextStyle(
                            //       color: Colors.grey[400], fontSize: 14.0),
                            // ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '￥${order.orderDetail[i].value.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 22.0),
                                ),
                                Text(
                                  order.orderDetail[i].count > 0
                                      ? 'x${order.orderDetail[i].count}'
                                      : '',
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ));
    }
    Widget list = Column(children: child);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0.0,
            title: Text(
              '订单详情',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                loading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: 60.0,
                              color: Theme.of(context).primaryColor,
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.credit_card),
                                  Text(
                                    orderStatus(
                                        orderDetail.orderList.orderType),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22.0),
                                  )
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    '收货人：${orderDetail.orderList.consignee}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    '联系电话：${orderDetail.orderList.phone}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    '收货地址：${orderDetail.orderList.specAddress}',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.all(10.0),
                          //   child: Row(
                          //     children: <Widget>[
                          //       Text('留言：'),
                          //       Text(orderDetail.data.order.remarks),
                          //     ],
                          //   ),
                          // ),
                          Container(
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              '订单号：${orderDetail.orderList.orderId}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          orderListUI(orderDetail.orderList, context),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '商品总额',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '￥${orderDetail.orderList.value.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(10.0),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: <Widget>[
                                //       // Text(
                                //       //   '配送费',
                                //       //   style: TextStyle(fontSize: 16.0),
                                //       // ),
                                //       // Text(
                                //       //   '￥${orderDetail.data.order.freightAmount.toString()}',
                                //       //   style: TextStyle(
                                //       //       fontSize: 16.0, color: Colors.red),
                                //       // ),
                                //     ],
                                //   ),
                                // ),
                                // Container(
                                //   padding: EdgeInsets.all(10.0),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: <Widget>[
                                //       // Text(
                                //       //   '优惠券',
                                //       //   style: TextStyle(fontSize: 16.0),
                                //       // ),
                                //       // Text(
                                //       //   '￥${orderDetail.data.order.couponAmount.toString()}',
                                //       //   style: TextStyle(
                                //       //       fontSize: 16.0, color: Colors.red),
                                //       // ),
                                //     ],
                                //   ),
                                // ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '付款：',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '￥${orderDetail.orderList.value.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(
                                //   padding: EdgeInsets.all(10.0),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: <Widget>[
                                //       Text(
                                //         '下单时间：',
                                //         style: TextStyle(fontSize: 16.0),
                                //       ),
                                //       Text(
                                //           '${orderDetail.data.order.createTime}'),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          )
                        ],
                      )
                    : Container(
                        child: Center(
                          child: Text('数据加载中'),
                        ),
                      )
              ])))
        ]),
        bottomNavigationBar: orderDetail != null ? Container(
          height: 45.0,
          padding: EdgeInsets.only(
            right: 10.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
             orderDetail.orderList.orderType == 1 || orderDetail.orderList.orderType == 2? InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {},
                child: Container(
                  height: 36.0,
                  width: 82.0,
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Colors.grey[400]),
                  ),
                  child: Center(
                    child: Text('取消订单'),
                  ),
                ),
              ): Container(),
              orderDetail.orderList.orderType == 1?
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {},
                child: Container(
                  height: 36.0,
                  width: 82.0,
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Text(
                      '继续支付',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ): Container(),
              orderDetail.orderList.orderType == 3?
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {},
                child: Container(
                  height: 36.0,
                  width: 82.0,
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Text('确认收货', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ): Container(),
              orderDetail.orderList.orderType == 5?
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {},
                child: Container(
                  height: 36.0,
                  width: 82.0,
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Colors.grey[400]),
                  ),
                  child: Center(
                    child: Text('去评价'),
                  ),
                ),
              ): Container()
            ],
          ),
        ):Container(),
        );
  }
}
