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
      'Hi, Flutter.\n 你真是太神奇了!',
      style: TextStyle(
        fontSize: 30,
        color: Colors.blue,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.bold,),
      textAlign: TextAlign.justify,
      maxLines: 3,
    );

    // 建立appBody物件
    var appBody = Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(50),
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      transform: Matrix4.rotationZ(0.1),
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
        backgroundColor: Colors.amber,

      ),
    );

    return app;
  }

}
