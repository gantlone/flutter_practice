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

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {

  String _inputName = '';

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: _inputName);
    nameController.value = TextEditingValue(
        text: _inputName,
        selection: TextSelection.collapsed(offset: _inputName.length)
    );

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
          setState(() {
            _inputName = nameController.text;
          });
          // FocusScope.of(context).unfocus();
        },
        child: const Text('確定'));


    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(child: nameField, width: 200, margin: const EdgeInsets.symmetric(vertical: 10),),
          Container(child: btn, margin: const EdgeInsets.symmetric(vertical: 10),),
          Text(_inputName, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );

    return widget;
  }

}