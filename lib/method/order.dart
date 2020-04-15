import 'dart:convert';
import 'package:flutter_shop/config/web.config.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/utils/httpUtils.dart';

Future getUserOrder(data) async {
  var url = webApi['orderList'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  try {
   var response = await HttpUtil().postToken(url, token,data: jsonEncode(data));
   return response; 
  } catch (e) {
    print(e);
  }
}

Future getUserOrderDetail(data) async {
  var url = webApi['orderDetail'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  try {
    var response = await HttpUtil().postToken(url, token,data: jsonEncode(data));
    return response;
  } catch (e) {
    print(e);
  }
}