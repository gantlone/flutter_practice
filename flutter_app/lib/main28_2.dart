import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatelessWidget{
  final ValueNotifier<String> _msg = ValueNotifier(''); //要顯示的訊息

  @override
  Widget build(BuildContext context) {
    //建立App的操作畫面
    final btn = IconButton(
      onPressed: () => _msg.value = '你按下手機按鈕',
      icon: const Icon(Icons.phone_android, color: Colors.white,),
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );

    final menu = PopupMenuButton(
      itemBuilder: (context){
        return <PopupMenuEntry>[
          const PopupMenuItem(
            child: Text('第一項', style: TextStyle(fontSize: 20),),
            value: 1,),
          const PopupMenuDivider(),
          const PopupMenuItem(
            child: Text('第二項', style: TextStyle(fontSize: 20),),
            value: 2,),
        ];
      },
      onSelected: (value){
        switch(value){
          case 1:
            _msg.value = '第一項';
            break;
          case 2:
            _msg.value = '第87項';
            break;
        }
      },
    );

    //建立AppBar
    final appBar = AppBar(
      title: const Text('App Bar 範例'),
      leading: InkWell(
        child: const Icon(Icons.menu),
        onTap: () => _msg.value = '你按下按鈕',
      ),
      automaticallyImplyLeading: false,
      actions: [btn, menu],
    );


    final appHomePage = Scaffold(
      appBar: appBar,
      body: ValueListenableBuilder<String>(
        builder: _showMsg,
        valueListenable: _msg,
      ),
    );

    return appHomePage;
  }

  Widget _showMsg(BuildContext context, String msg, Widget? child){
    final widget = Text(msg,
      style: const TextStyle(fontSize: 20),
    );

    return widget;
  }
}

