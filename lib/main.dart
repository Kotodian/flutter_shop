import 'package:flutter/material.dart';
import 'package:flutter_shop/page/splash.dart';
import 'package:flutter_shop/router/index.dart';
import 'package:flutter_shop/utils/cache.dart';
//import 'package:flutter_shop/page/splash.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shop/utils/rem.dart';
import 'package:provider/provider.dart';

import 'model/index.dart';
//import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sq = await SpUtil.getInstance();
  var token = sq.getString('token');
  var userName = sq.getString('userName');
  var image = sq.getString('userImg');
  runApp(MyApp(token, userName,image));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp(this.token, this.userName,this.image);

  final String token;

  final String userName;

  final String image;
  
  @override
  Widget build(BuildContext context) {
   Rem.setDesignWidth(750.0);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => Model(token, userName,image))
      ],
      child: Consumer<Model>(
        builder: (context, model, widget) {
          return RestartWidget(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              //theme: ThemeData(backgroundColor: Colors.transparent),
              // 监听路由跳转
              onGenerateRoute: (RouteSettings settings) {
                return Router.run(settings);
              },
              home: Scaffold(
                resizeToAvoidBottomPadding: false,
                body: SplashScreen(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  static restartApp(BuildContext context) {
    final _RestartWidgetState state =
        context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}