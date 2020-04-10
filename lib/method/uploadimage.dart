import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_shop/utils/httpUtils.dart';

Future uploadImage(File file,String token) async {

  String path = file.path;
  var name = path.substring(path.lastIndexOf("/") + 1,path.length);
  var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
  var image = await MultipartFile.fromFile(
    path,
    filename: name
  );
  FormData formData = FormData.fromMap({
    "headerImg": image
  });

  var respone = await HttpUtil().postToken("/cus/upload",token,data: formData);
  return respone;
}