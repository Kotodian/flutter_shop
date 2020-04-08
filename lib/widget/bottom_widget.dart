import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> with SingleTickerProviderStateMixin {
  
  TabController tabController;
  List colors = [Colors.blue,Colors.pink,Colors.orange];
  
  int currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3)..addListener((){
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
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.fiber_new, size: 30),
          Icon(Icons.person, size: 30)
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        
        },
      ),
    );
  }
}