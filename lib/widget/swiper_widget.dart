
// 轮播图
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperWidget extends StatefulWidget {
  @override
  _SwiperWidgetState createState() => _SwiperWidgetState();
}

class _SwiperWidgetState extends State<SwiperWidget> {
  final List<String> swiperImg = [
    "assets/images/coffee1.jpg",
    "assets/images/coffee2.jpg",
    "assets/images/coffee3.jpg"
  ];
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width - 100,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.asset(swiperImg[index],fit: BoxFit.contain);
        },
        itemCount: swiperImg.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 6.0,
            activeSize: 6.0,
            color: Colors.grey
          ),
        ),
        autoplay: true,
      ),
    );
  }
}