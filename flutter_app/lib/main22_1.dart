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

  //AnimatedContainer的高度
  final ValueNotifier<double> _barHeight = ValueNotifier(100);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: Text('動畫範例'),
    );

    // 建立App的操作畫面
    var btn = ElevatedButton(
        onPressed: () {
          _barHeight.value = _barHeight.value == 100 ? 400 : 100;
          },
        child: const Text('改變高度', style: TextStyle(fontSize: 18, color: Colors.white)),
        style:ElevatedButton.styleFrom(primary: Colors.lightBlue, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    );

    final widget = Center(
      child: Container(
        height: 500,
        child:Column(
          children: <Widget>[
            ValueListenableBuilder(
                valueListenable: _barHeight,
                builder: _animatedContainerBuilder
            ),
            Container(
              child: btn,
              margin: const EdgeInsets.symmetric(vertical: 20),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );

    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }
}

Widget _animatedContainerBuilder(BuildContext context, double barHeight, Widget? child){
  final wid = AnimatedContainer(
      width: 60.0,
      height: barHeight,
      color: Colors.orangeAccent,
      duration: const Duration(seconds: 1),
  );

  return wid;
}

