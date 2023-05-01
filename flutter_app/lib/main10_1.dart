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
    final widget = Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.yellow,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            elevation: 8,
          ),

          onPressed: () => _showSnackBar(context, '你按下按鈕'),
          child: const Text('顯示SnackBar訊息',
              style: TextStyle(fontSize: 20, color: Colors.redAccent))
      ),
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