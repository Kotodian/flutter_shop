import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/page/customer/addAddress.dart';
import 'package:flutter_shop/page/customer/address.dart';
import 'package:flutter_shop/page/customer/mine.dart';
import 'package:flutter_shop/page/customer/register.dart';
import 'package:flutter_shop/page/goodsDetail/index.dart';
import 'package:flutter_shop/page/home.dart';
import 'package:flutter_shop/page/index.dart';
import 'package:flutter_shop/page/order/index.dart';
import 'package:flutter_shop/page/order/orderDetail.dart';
import 'package:flutter_shop/page/order/orderList.dart';
import 'package:flutter_shop/router/404.dart';
import 'package:flutter_shop/page/customer/login.dart';
class Router {

  static Map<String, Function> routes = {
    '/index': (context,{arguments}) => Home(), // 底部
    '/home': (context,{arguments}) => HomePage(), // 首页
    '/login': (context,{arguments}) => Login(), // 登录
    '/register': (context,{arguments}) => Register(), //注册
    '/mine': (context,{arguments}) => Mine(), // 我的
    '/coffeeDetail': (context, {arguments}) => GoodsDetail(arguments: arguments), //咖啡详情
    '/confirmOrder': (context,{arguments}) => OrderPage(), //确认订单
    '/orderMap': (context,{arguments}) => OrderMap(), // 地址管理
    '/addMap': (context,{arguments}) => AddMap(), //添加地址
    '/orderList': (context,{arguments}) => OrderListPage(arguments: arguments), // 订单管理
    '/orderDetail': (context,{arguments}) => OrderDetailPage(arguments: arguments) //订单详情
  };

  static run(RouteSettings settings) {
    final Function pageContentBuilder = Router.routes[settings.name];

    if(pageContentBuilder != null) {
      if(settings.arguments != null) {
        return MaterialPageRoute(builder: (context) => pageContentBuilder(context,arguments: settings.arguments));
      } else {
        return MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      }
    } else {
      return MaterialPageRoute(builder: (context) => NoFoundPage());
    }
  }

  static link(Widget child, String routeName, BuildContext context, [Map params, Function callBack]) {
    return GestureDetector(
      onTap: (){
        if(params != null) {
          Navigator.pushNamed(context, routeName,arguments: params).then((onValue) {
            if (callBack != null) {
              callBack();
            }
          });
        } else {
          Navigator.pushNamed(context, routeName).then((onValue) {
            if (callBack != null) {
              callBack();
            }
          });
        }
      },
      child: child,
    );
  }
  // 方法跳转
  static push(String routeName, BuildContext context,
      [Map parmas, Function callBack]) {
    if (parmas != null) {
      Navigator.pushNamed(context, routeName, arguments: parmas)
          .then((onValue) {
        if (callBack != null) {
          callBack();
        }
      });
    } else {
      Navigator.pushNamed(context, routeName).then((onValue) {
        if (callBack != null) {
          callBack();
        }
      });
    }
  }

  static pop(context) {
    Navigator.of(context).pop();
  }
}