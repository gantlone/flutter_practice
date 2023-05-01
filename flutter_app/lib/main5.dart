import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 建立appTitle物件
    var appTitle = const Text('第一個Flutter App');

    // 建立hiFlutter物件
    var hiFlutter = const Text(
      'Hi, Flutter.',
      style: TextStyle(fontSize: 30),
    );

    // 建立appBody物件
    var appBody = Center(
      child: hiFlutter,
    );

    // 建立appBar物件
    var appBar = AppBar(
      title: appTitle,
    );

    // 建立app物件
    var app = MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: appBody,
      ),
    );

    return app;
  }

}
