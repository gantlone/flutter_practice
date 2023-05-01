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
  final ValueNotifier<double> _opacity = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: Text('動畫範例'),
    );

    // 建立App的操作畫面
    var btn = ElevatedButton(
      onPressed: () {
        _opacity.value = 0;
      },
      child: const Text('改變透明度', style: TextStyle(fontSize: 18, color: Colors.white)),
      style:ElevatedButton.styleFrom(primary: Colors.lightBlue, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    );

    final widget = Center(
      child: Container(
        height: 500,
        child:Column(
          children: <Widget>[
            ValueListenableBuilder(
                valueListenable: _opacity,
                builder: _textOpacityBuilder
            ),
            Container(
              child: btn,
              margin: const EdgeInsets.symmetric(vertical: 20),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _textOpacityBuilder(BuildContext context, double opacity, Widget? child){
    final wid = AnimatedOpacity(
      child: Image.asset('assets/1.jpg'),
      duration: const Duration(seconds: 1),
      opacity: opacity,
      onEnd: () => _opacity.value = 1.0,
    );

    return wid;
  }
}



