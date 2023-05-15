import 'package:flutter/material.dart';
import 'package:flutter_app/main5.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{

  //儲存要顯示的姓名
  final ValueNotifier<String> _name = ValueNotifier('');

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('儲存資料'),
    );

    //建立App的操作畫面
    final nameController = TextEditingController();
    final nameField = TextField(
      controller: nameController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        labelText: '輸入姓名',
        labelStyle: TextStyle(fontSize: 20)
      ),
    );

    final btnSaveName = ElevatedButton(
        onPressed: () => _saveName(nameController.text),
        child: const Text(
          '儲存',
          style: TextStyle(fontSize: 20,color: Colors.redAccent),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 8
        ),
    );

    final btnReadName = ElevatedButton(
      onPressed: () => _readName(),
      child: const Text(
        '讀取',
        style: TextStyle(fontSize: 20,color: Colors.redAccent),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 8
      ),
    );

    final wid = Center(
      child: Column(
        children: <Widget>[
          Container(
            child: nameField,
            width: 200,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Container(
            child: btnSaveName,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Container(
            child: btnReadName,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Container(
            child: ValueListenableBuilder<String>(
              builder: _nameWidgetBuilder,
              valueListenable: _name,
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );

    //結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: wid
    );

    return appHomePage;

  }

  //儲存姓名的方法，非同步方式執行
  _saveName(String name) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('name', name);
  }

  //讀取姓名的方法，非同步方法執行
  _readName() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    _name.value = sp.getString('name') ?? '';
  }

  Widget _nameWidgetBuilder(BuildContext context, String name, Widget? child){
    final widget = Text(name,
    style: const TextStyle(fontSize: 20),);
    return widget;
  }
}

