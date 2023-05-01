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
  final ValueNotifier<bool> _showText = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: Text('動畫範例'),
    );

    // 建立App的操作畫面
    var btn = ElevatedButton(
      onPressed: () {
        _showText.value = !_showText.value;
      },
      child: const Text('改變透明度', style: TextStyle(fontSize: 18, color: Colors.white)),
      style:ElevatedButton.styleFrom(primary: Colors.lightBlue, padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    );

    final widget = Center(
      child: Container(
        height: 500,
        child:Column(
          children: <Widget>[
            ValueListenableBuilder<bool>(
                valueListenable: _showText,
                builder: _animatedCrossFadeBuilder,
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

  Widget _animatedCrossFadeBuilder(BuildContext context, bool showText, Widget? child){
    final wid = AnimatedCrossFade(
      firstChild: Container(
      child:Image.asset('assets/1.jpg')),
      secondChild: Container(
          child:Image.asset('assets/2.jpg')),
      duration: const Duration(seconds: 1),
      crossFadeState: _showText.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );

    return wid;
  }
}



