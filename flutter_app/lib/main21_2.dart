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
  late Animation _anim;
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

    _anim = Tween(
      begin: -250.0,
      end: 250.0,
    ).animate(curvedAnim)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) _animCtrl.reverse();
        else if (status == AnimationStatus.dismissed) _animCtrl.forward();
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
    var widget = Transform.translate(
      child: Image.asset('assets/1.jpg'),
      offset: Offset(0, _anim.value),
    );

    return widget;
  }
}
