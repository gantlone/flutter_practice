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


    // 建立appBody物件
    var appBody = AppBody();


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
   AppBody({super.key});

   final ValueNotifier<String> _inputName = ValueNotifier('');

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
          _inputName.value = nameController.text;
          },
        child: const Text('確定'));


    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(child: nameField, width: 200, margin: const EdgeInsets.symmetric(vertical: 10),),
          Container(child: btn, margin: const EdgeInsets.symmetric(vertical: 10),),
          Container(
            child: ValueListenableBuilder<String> (
            builder: _inputNameWidgetBuilder,
            valueListenable: _inputName,
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),),
        ],
      ),
    );

    return widget;
  }

}

Widget _inputNameWidgetBuilder(BuildContext context, String inputName, Widget? child) {
  final widget = Text(inputName,
    style: const TextStyle(fontSize: 20),);
  return widget;
}