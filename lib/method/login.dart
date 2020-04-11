import 'dart:convert';

import 'package:flutter_shop/config/web.config.dart';
import 'package:flutter_shop/utils/httpUtils.dart';

Future loginWithMobile({String username,String password}) async {
  var url = webApi['cusLogin'];
  var response = await HttpUtil().post(url,data:jsonEncode({"username": username,"password":password}));
  return response;
}
