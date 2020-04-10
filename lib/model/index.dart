import 'package:flutter/material.dart';

class Model with ChangeNotifier {
  Model(this._token,this._userName,this._image);

  String _token;
  String _userName;
  String _image;
  String get token => _token;
  String get userName => _userName;
  String get image => _image;
  void setToken(token) {
    _token = token;
    notifyListeners();
  }

  void setUserName(name) {
    _userName = name;
    notifyListeners();
  }

  void setImage(image) {
    _image = image;
    notifyListeners();
  }
}