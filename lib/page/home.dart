import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/method/categoryList.dart';
import 'package:flutter_shop/model/coffeetype.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/rem.dart';
import 'package:flutter_shop/widget/swiper_widget.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Coffeetype> categoryList = [];
  @override
  void initState() {
    getCategoryList().then((data){
      var list = CoffeetypeList.fromJson(data['data']);
      setState(() {
        categoryList = list.coffeetype;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return Center(
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0)
        ),
      );
    } else {
      var sliversList = [
        buildSwiper(),
        buildChannel()
      ];
    return SafeArea(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers:sliversList
      )
    );
    }
  }
  Widget buildSwiper() {
    return SliverList(
       delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return SwiperWidget();
      }, childCount: 1),
    );
  }
  // 渠道
  SliverGrid buildChannel() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 1.3,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Router.link(
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: new Container(
                      padding: EdgeInsets.only(
                          bottom: Rem.getPxToRem(4),
                          left: Rem.getPxToRem(25),
                          top: Rem.getPxToRem(25),
                          right: Rem.getPxToRem(25)),
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: categoryList[index].image,
                          fit: BoxFit.fitWidth
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: new Container(
                      child: Center(
                        child: new Text(
                          categoryList[index].name,
                          style: TextStyle(
                            fontSize: Rem.getPxToRem(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // TODO: 修改
              '/catalog',
              context,
              {
                'code': categoryList[index].code,
              });
        },
        childCount: 5,
      ),
    );
  }
}