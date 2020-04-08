import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/page/splash.dart';
import 'package:flutter_shop/page/home.dart';

// 启动页面
Handler splashHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params) {
    return SplashScreen();   
  }
);

// 首页
Handler homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String,List<String>> params) {
    return HomePage();   
  }
);