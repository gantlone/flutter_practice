import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.yellow,),
      textAlign: TextAlign.justify,
      maxLines: 3,
    );

    // 建立appBody物件
    var img = Image.asset('assets/images.jpg',
        scale: 1,
        width: 200000,
        height: 200000,
      fit: BoxFit.fitHeight,);
    var appBody = Center(
      child: img,
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
