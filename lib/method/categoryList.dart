import 'dart:convert';

import 'package:flutter_shop/config/web.config.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/utils/httpUtils.dart';

// 获取分类列表
Future getCategoryList() async {
  try {
    var url = webApi['categoryList'];
    var data = jsonEncode({"page":0,"pagesize":999});
    var response = await HttpUtil().post(url,data: data);
    // var response = await Dio().post(url,data: data);
    return response;
  } catch (e) {
    print(e);
  }
}

Future getCoffeeList(int page, int pagesize,String code) async {
  try {
    var url = webApi['coffeeList'];
    var data = {
      "PageInfo":{
        "page":page,
        "pageSize":pagesize
      },
      "code": code
    };
    var response = await HttpUtil().post(url,data: jsonEncode(data));
    return response;
  } catch (e) {
    print(e);
  }
}

Future getCoffeeType(String code) async {
  try {
    var url = webApi['coffeeType'];
    var data = {
      "code": code
    };
    var response = await HttpUtil().post(url,data: jsonEncode(data));
    return response;
  } catch (e) {
    print(e);
  }
}
Future getCoffeeByUUID(String uuid) async {
    try {
      var url = webApi['coffeeDetail'];
      var data = {
        "uuid": uuid
      };
      var response = await HttpUtil().post(url,data: jsonEncode(data));
      return response;
    } catch (e) {
      print(e);
    }
}


Future getCoffeeSpecValue(data) async {
    try {
      var url = webApi['coffeeValue'];
      var sq = await SpUtil.getInstance();
      var token = sq.getString('token');
      var response = await HttpUtil().postToken(url,token,data: jsonEncode(data));
      return response;
    } catch (e) {
      print(e);
    }
}