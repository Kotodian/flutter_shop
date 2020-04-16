import 'dart:convert';

import 'package:flutter_shop/config/web.config.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/utils/httpUtils.dart';

Future getCartList() async {
  var url = webApi['cart'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  var userId = sq.getString('userId');
  var data = {
    "pageInfo": {
        "page": 1,
        "pageSize": 999
    },
    "user_id": userId
  };
  try {
    var response = HttpUtil().postToken(url, token,data: data);
    return response;
  } catch (e) {
    print(e);
  }
}

Future AddCart(coffeeId,spec) async {
  var url = webApi['addCart'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  var userId = sq.getString('userId');
  var data = {
    "coffee_id": coffeeId,
    "user_id": userId,
    "spec": spec
  };
  try {
    var response = HttpUtil().postToken(url, token,data: jsonEncode(data));
    return response;
  } catch (e) {
    print(e);
  }
}

Future ReduceCart(coffeeId) async {
  var url = webApi['reduceCart'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  var userId = sq.getString('userId');
  var data = {
    "coffee_id": coffeeId,
    "user_id": userId
  };
  try {
    var response = HttpUtil().postToken(url, token,data: data);
    return response;
  } catch (e) {
    print(e);
  }
}

Future checkCartStatus(data) async {
  var url = webApi['checkStatus'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  try {
    var response = HttpUtil().postToken(url, token,data: data);
    return response;
  } catch (e) {
    print(e);
  }
}