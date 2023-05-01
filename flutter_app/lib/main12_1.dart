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
    final nameController = TextEditingController();
    final nameField = TextField(
      controller: nameController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        labelText: '輸入姓名',
        labelStyle: TextStyle(fontSize: 20),
      ),
      // onSubmitted: (_) => {
      //   _showSnackBar(context, nameController.text),
      //   FocusScope.of(context).unfocus(),
      // },
    );

    final btn = ElevatedButton(
        onPressed: (){
          _showSnackBar(context, nameController.text);
          // FocusScope.of(context).unfocus();
        },
        child: const Text('確定'));


    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(child: nameField, width: 200, margin: const EdgeInsets.symmetric(vertical: 10),),
          Container(child: btn, margin: const EdgeInsets.symmetric(vertical: 10),)
        ],
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