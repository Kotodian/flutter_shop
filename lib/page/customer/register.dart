import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
TextEditingController _unameController = new TextEditingController();
TextEditingController _pwdController = new TextEditingController();
TextEditingController _nicknameController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }
  void register(context) async {

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
                  TextFormField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                          labelText: "别名",
                          hintText: "您的别名",
                          icon: Icon(Icons.person)),
                      obscureText: true,
                      //校验别名
                      validator: (v) {
                        if (v.trim().length == 0) {
                          return '别名不能为空';
                        } else if (v.trim().length < 6){
                          return '别名字符不能小于6位';
                        } else {
                          return null;
                        }
                      }),                      
                  // 注册按钮
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            padding: EdgeInsets.all(15.0),
                            child: Text("注册"),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if ((_formKey.currentState as FormState)
                                  .validate()) {
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
