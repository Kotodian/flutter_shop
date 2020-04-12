import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/page/cart/index.dart';
import 'package:flutter_shop/page/customer/mine.dart';
import 'package:flutter_shop/page/home.dart';
import 'package:flutter_shop/page/sort/index.dart';
import 'package:flutter_shop/widget/bottom_widget.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
 TabController tabController;
  List colors = [Colors.blue,Colors.pink,Colors.orange,Colors.purple,Colors.red];
  int currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 5)..addListener((){
      setState(() {
        currentIndex = tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: colors[currentIndex],      
        initialIndex: currentIndex,
        items:bottomNavigationBar,
        onTap: (index) {
          this.setState(() {
            currentIndex = index;
          });
          tabController.animateTo(index, duration: Duration(milliseconds: 300),curve: Curves.ease);
        },
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          HomePage(),
          Sort(),
          Container(
            color: colors[2]
          ),
          CartPage(),
          Mine()
        ]),
    );
  }
}