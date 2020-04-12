

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/page/customer/mine.dart';
import 'package:flutter_shop/page/goodsDetail/index.dart';
import 'package:flutter_shop/page/home.dart';
import 'package:flutter_shop/page/index.dart';
import 'package:flutter_shop/router/404.dart';
import 'package:flutter_shop/page/customer/login.dart';
class Router {

  static Map<String, Function> routes = {
    '/index': (context,{arguments}) => Home(),
    '/home': (context,{arguments}) => HomePage(),
    '/login': (context,{arguments}) => Login(),
    '/mine': (context, {arguments}) => Mine(),
    '/coffeeDetail': (context, {arguments}) => GoodsDetail(arguments: arguments)
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
    Navigator.pop(context);
  }
}