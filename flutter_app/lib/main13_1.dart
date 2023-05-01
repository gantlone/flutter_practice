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

var trans = ['火車', '高鐵', '巴士'];

class AppBody extends StatelessWidget{
  AppBody({Key? key}) : super(key:key);

  final ValueNotifier<String> _itemName = ValueNotifier('');
  final ValueNotifier<int> _selectedItem = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
   final btn = ElevatedButton(
       onPressed: (){
         _itemName.value = _selectedItem.value < 0 ? '' : trans[_selectedItem.value];
       },
       child: const Text('確定'));

   final widget = Center(
     child: Column(
       children: <Widget>[
         Container(
           child: ValueListenableBuilder<int>(
             builder: _dropdownButtonBuilder, //下拉式選單
             valueListenable: _selectedItem,
           ),
           margin: const EdgeInsets.symmetric(vertical: 10),
         ),
         Container(
           child: btn,
           margin: const EdgeInsets.symmetric(vertical: 10),
         ),
         Container(
           child: ValueListenableBuilder<String>(
             builder: _itemNameWidgetBuilder,
             valueListenable: _itemName,
           )
         )
       ]
     )
   );

   return widget;
  }

  Widget _dropdownButtonBuilder(BuildContext context, int selectedItem, Widget? child){
    final btn = DropdownButton(
      items: <DropdownMenuItem>[
        DropdownMenuItem(
            child: Text(trans[0], style: const TextStyle(fontSize: 20)),
            value: 0),
        DropdownMenuItem(
            child: Text(trans[1], style: const TextStyle(fontSize: 20)),
            value: 1),
        DropdownMenuItem(
            child: Text(trans[2], style: const TextStyle(fontSize: 20)),
            value: 2),
      ],
      onChanged: (dynamic value) {
        _selectedItem.value = value as int;
      },
      hint: const Text('請選擇交通工具', style: TextStyle(fontSize: 20),),
      value: _selectedItem.value < 0 ? null : _selectedItem.value,
    );
    return btn;
  }

  Widget _itemNameWidgetBuilder(BuildContext context, String itemName, Widget? child){
    final widget = Text(itemName, style: const TextStyle(fontSize: 20),);
    return widget;
  }
}