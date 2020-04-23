import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/method/uploadimage.dart';
import 'package:flutter_shop/utils/cache.dart';
import 'package:flutter_shop/utils/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_shop/model/index.dart';
import 'package:flutter_shop/utils/rem.dart';
import 'package:flutter_shop/router/index.dart';



class Mine extends StatelessWidget {
  final List<Map<String, dynamic>> gridList = [
    {'name': '地址管理', 'icon': 'assets/images/address.png','route':'/orderMap'},
    {'name': '我的订单', 'icon': 'assets/images/order.png','route':'/orderList'},
    {'name': '退出登录', 'icon': 'assets/images/logout.png','route':''}
  ];
  var username;
  var userImg;
  void todo({int index, BuildContext context}) async {
    var item = gridList[index]['name'];
    if (item == '退出登录') {
      final model = Provider.of<Model>(context);
      var sq = await SpUtil.getInstance();
      sq.remove('token');
      model.setToken(null);
    }else if(item == '我的订单') {
      Router.push(gridList[index]['route'], context,{'orderType': 1});
    } else {
      Router.push(gridList[index]['route'], context);
    }
  }
  // 打开底部菜单
  void handleTap(context) { // 某个GestureDetector的事件
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => actionSheet(context),
      ).then((value) {});
  }
  // 从相册中获取图片
  Future getGalleryImage(context) async{
    final model = Provider.of<Model>(context);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      var response = await uploadImage(image,model.token);
      if(response['success']) {
        var sq = await SpUtil.getInstance();
        sq.putString('userImg',response['data']['user']['image']);
        model.setImage(response['data']['user']['image']);
        ToastUtils.showToast(response['msg']);
      } else {
        ToastUtils.showToast('上传头像失败');
      }
    } else {
      ToastUtils.showToast('未选择图片');
    }
  }
  // 拍照获取图片
  Future getCameraImage(context) async {
    final model = Provider.of<Model>(context);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if(image != null) {
      var response = await uploadImage(image,model.token);
      if(response['success']) {
        var sq = await SpUtil.getInstance();
        sq.putString('userImg',response['data']['user']['image']);
        model.setImage(response['data']['user']['image']);
        ToastUtils.showToast(response['msg']);
      } else {
        ToastUtils.showToast('上传头像失败');
      }
    } else {
        ToastUtils.showToast('未选择图片');
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    if (model.token != null) {
      return SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            buildHeader(context),
            buildItem(),
          ],
        ),
      );
    } else {
      return Center(
        child: RaisedButton(
          child: Text("请先登录！"),
          onPressed: () {
            Router.push('/login', context);
          },
        ),
      );
    }
  }

  SliverGrid buildItem() {
    return SliverGrid(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: 1,
      ),
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkResponse(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Container(
                  height: Rem.getPxToRem(120),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: Rem.getPxToRem(60),
                        child: Image.asset(
                          gridList[index]['icon'],
                          width: Rem.getPxToRem(60),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: Text(
                              gridList[index]['name'],
                              style: TextStyle(fontSize: Rem.getPxToRem(24)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              todo(index: index, context: context);
            },
          );
        },
        childCount: gridList.length,
      ),
    );
  }

  SliverList buildHeader(BuildContext context) {
    final model = Provider.of<Model>(context);
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          height: Rem.getPxToRem(300),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 0,
                left: 0,
                top: 0,
                bottom: 0,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://yanxuan.nosdn.127.net/d069279e5834bbca17065a9855a014bf.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: Rem.getPxToRem(60),
                left: Rem.getPxToRem(50),
                child:GestureDetector(
                  onTap: (){
                    handleTap(context);
                  },
                  child:Container(
                    width: Rem.getPxToRem(180),
                    height: Rem.getPxToRem(180),
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new NetworkImage(
                            model.image == null ? 'http://yanxuan.nosdn.127.net/8945ae63d940cc42406c3f67019c5cb6.png': '${model.image}'),
                        fit: BoxFit.cover,    
                        // centerSlice:
                        //     new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                      ),
                      borderRadius: BorderRadius.all(new Radius.circular(
                        Rem.getPxToRem(180),
                    )),
                  ),
                ),
                ),
              ),
              Positioned(
                child: Container(
                  child: Center(
                    child: Text(
                      '${model.userName}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  height: Rem.getPxToRem(80),
                ),
                top: Rem.getPxToRem(80),
                left: Rem.getPxToRem(260),
              ),
              Positioned(
                child: Container(
                  child: Center(
                    child: Text(
                      '普通用户',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  height: Rem.getPxToRem(80),
                ),
                top: Rem.getPxToRem(130),
                left: Rem.getPxToRem(260),
              )
            ],
          ),
        );
      }, childCount: 1),
    );
  }
  // 底部弹出菜单actionSheet
  Widget actionSheet(BuildContext context) {
    return new CupertinoActionSheet(
      title: new Text(
        '菜单'
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            '打开相机拍照',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'PingFangRegular',
            ),
          ),
          onPressed: () {
            // 打开相机拍照
            getCameraImage(context);
            // 关闭菜单
            Navigator.of(context).pop();
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            '打开相册，选取照片',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'PingFangRegular',
            ),
          ),
          onPressed: () {
            // 打开相册，选取照片
            getGalleryImage(context);
            // 关闭菜单
            Router.pop(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: new Text(
          '取消',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'PingFangRegular',
            color: const Color(0xFF666666),
          ),
        ),
        onPressed: () {
          // 关闭菜单
            Router.pop(context);
        },
      ),
    );
  }
}
