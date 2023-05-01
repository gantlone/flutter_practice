import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: Text('動畫範例'),
    );

    // 建立App的操作畫面
    final animationWrapper = _AnimationWrapper();

    final widget = Container(
      child: animationWrapper,
      alignment: Alignment.center,
    );

    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }
}

class _AnimationWrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationWrapperState();
}

class _AnimationWrapperState extends State<_AnimationWrapper>
    with SingleTickerProviderStateMixin {
  late Animation _transAnim, _rotateAnim;
  late AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    final curvedAnim = CurvedAnimation(
      parent: _animCtrl,
      curve: Curves.fastOutSlowIn,
    );

    _rotateAnim = Tween(
      begin: 0,
      end: 2 * pi,
    ).animate(curvedAnim)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animCtrl.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animCtrl.forward();
        }
      });

    _transAnim = Tween(
      begin: -200.0,
      end: 200.0,
    ).animate(curvedAnim)
      ..addListener(() {
        setState(() {});
      });

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Matrix4 rotateM = Matrix4.identity()..rotateZ(_rotateAnim.value);
    Matrix4 transM = Matrix4.identity()..translate(0.0,_transAnim.value,0.0);
    var widget = Transform(
      child: Image.asset('assets/1.jpg'),
      alignment: FractionalOffset.center,
      transform: transM *rotateM,
    );

    return widget;
  }
}
