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
    var appBody = Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
      onPressed: () {
        //顯示Toast訊息
        Fluttertoast.showToast(msg: '你按下按鈕',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
       backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 20);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        elevation: 8,
      ),
        child: const Text('顯示Toast訊息', style: TextStyle(fontSize: 30, color: Colors.red),),



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
