import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 建立appTitle物件
    var appTitle = const Text('第一個Flutter App');

    var text2 = Container(
        margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        child: const Text('物件2', style: TextStyle(fontSize: 30, color: Colors.red),));
    var img = Image.asset('assets/images.jpg');


    // 建立appBody物件
    var appBody = const AppBody();


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

class AppBody extends StatelessWidget {
  const AppBody({super.key});

  @override
  Widget build(BuildContext context) {
    final btn1 = ElevatedButton(
      child: const Text(
        'ElevatedButton',
        style: TextStyle(fontSize: 20, color: Colors.redAccent),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.yellow,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), //vertical: 垂直, horizontal: 水平
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), //按鈕邊緣半徑設定
        elevation: 8,
      ),
      onPressed: () => _showSnackBar(context, '你按下按鈕1'),
    );

    final btn2 = TextButton(
      child: const Text(
        'TextButton',
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
      onPressed: () => _showSnackBar(context, '你按下按鈕2'),
    );

    final btn3 = OutlinedButton(
      child: const Text(
        'Outlined\nButton',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: const BorderSide( //設定邊線
          color: Colors.red,
          style: BorderStyle.solid, //是否顯示邊緣 否為none
          width: 0.8, //邊線寬度
        )
      ),
      onPressed: () => _showSnackBar(context, '你按下按鈕3'),
    );

    final btn4 = IconButton(
      icon: const Icon(Icons.abc),
      iconSize: 40,
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      onPressed: () => _showSnackBar(context, '你按下按鈕4'),
      );

    final btn5 = FloatingActionButton(
      child: const Icon(Icons.heart_broken),
      elevation: 8,
      shape: const CircleBorder(),
      onPressed: () => _showSnackBar(context, '你按下按鈕5'),
    );

    final btn6 = ElevatedButton.icon(
      label: const Text(
        'ElevationButton.icon',
        style: TextStyle(fontSize: 20, color: Colors.green),
      ),
      icon: const Icon(
        Icons.hail,
        color: Colors.redAccent),
      style: ElevatedButton.styleFrom(
        primary: Colors.black12,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), //vertical: 垂直, horizontal: 水平
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)), //按鈕邊緣半徑設定
        elevation: 0,
      ),
      onPressed: () => _showSnackBar(context, '你按下按鈕6'),
    );


    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(child: btn1, margin: const EdgeInsets.symmetric(vertical: 10)),
          Container(child: btn2, margin: const EdgeInsets.symmetric(vertical: 10)),
          Container(child: btn3, margin: const EdgeInsets.symmetric(vertical: 10)),
          Container(child: btn4, margin: const EdgeInsets.symmetric(vertical: 10)),
          Container(child: btn5, margin: const EdgeInsets.symmetric(vertical: 10)),
          Container(child: btn6, margin: const EdgeInsets.symmetric(vertical: 10))],
        mainAxisAlignment: MainAxisAlignment.center,
      )
    );
    return widget;
  }

  void _showSnackBar(BuildContext context, String msg){
    //建立SnackBar物件
    final snackBar = SnackBar(
        content: Text(msg),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        action: SnackBarAction(
          label: 'Toast訊息',
          textColor: Colors.white,
          onPressed: () =>
              Fluttertoast.showToast(msg: '你按下SnackBar',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 20),
        )
    );

    //顯示snackBar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}