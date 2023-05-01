
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
    final btn = _DropdownWidget();


    final widget = Center(
        child: btn,
        heightFactor: 2,
    );

    return widget;
  }
}

class _DropdownWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _DropdownWidgetState();
  }
}

class _DropdownWidgetState extends State<_DropdownWidget>{
  int? SelectedValue;

  @override
  Widget build(BuildContext context){
    final btn = DropdownButton(
        items: const <DropdownMenuItem>[
          DropdownMenuItem(
              child: Text('第一項', style: TextStyle(fontSize: 20),),
              value: 1,),
          DropdownMenuItem(
            child: Text('第二項', style: TextStyle(fontSize: 20),),
            value: 2,),
          DropdownMenuItem(
            child: Text('第三項', style: TextStyle(fontSize: 20),),
            value: 3,),
        ],
        onChanged: (dynamic value){
          setState(() {
            SelectedValue = value as int;
          });
        },
        hint: const Text('請選擇', style: TextStyle(fontSize: 20),),
        value: SelectedValue,
    );

    return btn;
  }
}