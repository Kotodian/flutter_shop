import 'package:flutter/material.dart';
import 'package:flutter_shop/utils/rem.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_shop/model/index.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/method/login.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  void login(context) async {
    final sq = await SpUtil.getInstance();
    final model = Provider.of<Model>(context);
    var data = await loginWithMobile(username: _unameController.text, password: _pwdController.text);
    
    // print(data);
    sq.putString('token', data['data']['token']);
    sq.putString('userName', data['data']['user']['username']);
    sq.putString('userImg', data['data']['user']['image']);
    sq.putString('userId', data['data']['user']['uuid']);
    model.setToken(data['data']['token']);
    model.setUserName(data['data']['user']['nickname']);
    model.setImage(data['data']['user']['image']);
    Router.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  child: InkResponse(
    //     child: Text('点击登录！'),
    //     onTap: () {
    //       login(context);
    //     },
    //   ),
    return Material(
        child: SafeArea(
            child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(50, 50, 50, 40),
          child: CachedNetworkImage(
            imageUrl:
                'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1586425648389&di=5ba3bf34d9ed22ce0762e4e0e8f422c9&imgtype=0&src=http%3A%2F%2Fimg01.jituwang.com%2F171205%2F256756-1G20519532362.jpg',
                
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidate: true, //开启自动校验
              child: Column(
                children: <Widget>[
                  TextFormField(
                      controller: _unameController,
                      decoration: InputDecoration(
                          labelText: "手机号码",
                          hintText: "请输入您的手机号码",
                          icon: Icon(Icons.person)),
                      // 校验用户名
                      validator: (v) {
                        if (v.trim().length == 0) {
                          return '手机号码不能为空';
                        } else {
                          return null;
                        }
                      }),
                  TextFormField(
                      controller: _pwdController,
                      decoration: InputDecoration(
                          labelText: "密码",
                          hintText: "您的登录密码",
                          icon: Icon(Icons.lock)),
                      obscureText: true,
                      //校验密码
                      validator: (v) {
                        if (v.trim().length == 0) {
                          return '登录密码不能为空';
                        } else {
                          return null;
                        }
                      }),
                  // 登录按钮
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            child: Text("登录"),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if ((_formKey.currentState as FormState)
                                  .validate()) {
                                login(context);
                                //验证通过提交数据
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    )));
  }
}
