import 'dart:convert';

import 'package:flutter_shop/utils/httpUtils.dart';

Future loginWithMobile({String username,String password}) async {
  var response = await HttpUtil().post('/base/cuslogin',data:jsonEncode({"username": username,"password":password}));
  return response;
}
