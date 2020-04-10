import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_shop/config/web.config.dart';
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