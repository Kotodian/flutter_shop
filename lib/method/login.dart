import 'dart:convert';

import 'package:flutter_shop/config/web.config.dart';
import 'package:flutter_shop/utils/httpUtils.dart';


// 登录
Future loginWithMobile({String username,String password}) async {
  var url = webApi['cusLogin'];
  var response = await HttpUtil().post(url,data:jsonEncode({"username": username,"password":password}));
  return response;
}

// 注册
Future registerWithMobile(String username,String password,String nickname) async {
  var url = webApi['cusRegister'];
  var response = await HttpUtil().post(url,data:jsonEncode({"username": username,"password":password,"nickname": nickname}));
  return response;
}
// 获得手机验证码
Future getPhoneCaptcha(data) async {
  var url = webApi['phone'];
  var response = await HttpUtil().post(url,data: jsonEncode(data));
  return response;
}
