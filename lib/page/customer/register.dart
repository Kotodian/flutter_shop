import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/method/login.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/fluttertoast.dart';
import 'package:flutter_shop/utils/validator.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
TextEditingController _unameController = new TextEditingController(); //用户名
TextEditingController _pwdController = new TextEditingController(); // 密码
TextEditingController _nicknameController = new TextEditingController(); //昵称
bool  isButtonEnable=true;      //按钮状态  是否可点击
String buttonText='发送验证码';   //初始文本
int count=60;                     //初始倒计时时间
Timer timer;                       //倒计时的计时器
String phone;
TextEditingController mController=TextEditingController();

GlobalKey _formKey = new GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }
  Future register(context) async {
    var data  = await registerWithMobile(_unameController.text, _pwdController.text,_nicknameController.text);
    if(data['success']) {
      ToastUtils.showToast(data['msg']);
      Router.pop(context);
    } else {
      ToastUtils.showToast(data['msg']);
    }
  }
    void _buttonClickListen(){
    setState(() async{
      if(isButtonEnable){    
        var data = {
          "phone": _unameController.text
        };     //当按钮可点击时
        var res = await getPhoneCaptcha(data);
        phone = res['data']['captcha'];

        isButtonEnable=false;   //按钮状态标记
        _initTimer();

        return null;            //返回null按钮禁止点击
      }else{                    //当按钮不可点击时
//        debugPrint('false');
        return null;             //返回null按钮禁止点击
      }
    });
  }
  void _initTimer(){
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if(count==0){
          timer.cancel();             //倒计时结束取消定时器
          isButtonEnable=true;        //按钮可点击
          count=60;                   //重置时间
          buttonText='发送验证码';     //重置按钮文本
        }else{
          buttonText='重新发送($count)';  //更新文本内容
        }
      });
    });
  }
  @override
  void dispose() { 
    timer?.cancel();      //销毁计时器
    timer=null;
    mController?.dispose();
    super.dispose();
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
                        } else if (!ValidatorUtil.isChinaPhoneLegal(v)){
                          return '该手机号非中国手机号';
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
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  crossAxisAlignment: CrossAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: <Widget>[
                    Text('验证码',style: TextStyle(fontSize: 13,color: Color(0xff333333)),),
                    Expanded(
                      child: Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                      child: TextFormField(
                        maxLines: 1,
                        onSaved: (value) { },
                        controller: mController,
                        textAlign: TextAlign.left,
                        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(6)],
                        decoration: InputDecoration(
                          hintText: ('填写验证码'),
                          contentPadding: EdgeInsets.only(top: -5,bottom: 0),
                          hintStyle: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 13,
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        validator: (v) {
                          if(v.trim().length == 0) {
                            return '验证码不能为空';
                          }else if(v != phone) {
                            return '验证码错误';
                          } else {
                            return null;
                          }
                        },
                      ),),
                    ),
                    Container(
                      child: FlatButton(
                        disabledColor: Colors.grey.withOpacity(0.1),     //按钮禁用时的颜色
                        disabledTextColor: Colors.white,                   //按钮禁用时的文本颜色
                        textColor:isButtonEnable?Colors.white:Colors.black.withOpacity(0.2),                           //文本颜色
                        color: isButtonEnable?Color(0xff44c5fe):Colors.grey.withOpacity(0.1),                          //按钮的颜色
                        splashColor: isButtonEnable?Colors.white.withOpacity(0.1):Colors.transparent,
                        shape: StadiumBorder(side: BorderSide.none),
                        onPressed: (){ setState(() {
                          _buttonClickListen();
                        });},
//                        child: Text('重新发送 (${secondSy})'),
                        child: Text('$buttonText',style: TextStyle(fontSize: 13,),),
                      ),
                    ),
                  ],
              ),
                  
                  
                  // 注册按钮
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
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
                                register(context);
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
