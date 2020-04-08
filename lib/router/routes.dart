
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/router/router_handler.dart';

class Routes {
  static String root = '/home';
  static String splash = '/splash';
  static void configureRoutes(Router router){
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params) {
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
        return;
      }
    );
    router.define(root, handler: homeHandler);
    router.define(splash, handler: splashHandler);
  }
}

