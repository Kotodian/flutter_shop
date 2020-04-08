// 启动页面
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  
  
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() { 
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 1.0,end: 1.0).animate(_animationController);
    _animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        
        Navigator.of(context).pushNamed('/home');
      }
    });
    _animationController.forward();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ConstrainedBox(
        //让他的child充满整个屏幕
        constraints: BoxConstraints.expand(),
        child:Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              child: Image.asset(
                'assets/images/launch_image.jpg',
                 scale: 1.0,
                 fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 50,
              right: 20,
              child: FlatButton(
                color: Colors.yellow,
                highlightColor: Colors.blue,
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Text("跳过"),
                onPressed: (){
                  _animationController.dispose();
                },
              ),
            )
          ],
        ) 
      )
    );
  }
  
}