import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 建立appTitle物件
    var appTitle = const Text('第一個Flutter App');

    //建立三個Text物件，使用ROW排列
    var text1 = Expanded(child: Container(
        margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: const Text('物件1', style: TextStyle(fontSize: 20))));
    var text2 = Container(
        margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: const Text('物件2', style: TextStyle(fontSize: 20)));
    var text3 = Container(
        margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: const Text('物件3', style: TextStyle(fontSize: 20)));



    // 建立appBody物件
    var appBody = Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[text1, text2, text3],
    ));

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
