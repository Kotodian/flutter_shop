
import 'package:flutter_shop/config/web.config.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/utils/httpUtils.dart';

// 获得客户地址
Future getAddressList(data) async {
  var url = webApi['addressList'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  try {
    var response = await HttpUtil().postToken(url, token,data: data);
    return response;
  } catch (e) {
    print(e);
  }
}

// 新增地址
Future addAddress(data) async {
  var url = webApi['addAddress'];
  final sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  try {
    var response = await HttpUtil().postToken(url, token,data: data);
    return response;
  } catch (e) {
    print(e);
  }
}


