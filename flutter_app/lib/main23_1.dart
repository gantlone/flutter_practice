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

class MyHomePage extends StatelessWidget {

  //紀錄被點選的項目名稱
  final ValueNotifier<String> _selectedItem = ValueNotifier('');

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('ListView範例'),
    );

    //建立App的操作畫面
    var listView = ListView(
      children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: const Text('第一項', style: TextStyle(fontSize: 20),),
              onTap: () => _selectedItem.value = '我愛羅晟原',
            ),
            ListTile(
              title: const Text('第二項', style: TextStyle(fontSize: 20),),
              onTap: () => _selectedItem.value = '點選第二項',
            ),
            ListTile(
              title: const Text('第三項', style: TextStyle(fontSize: 20),),
              onTap: () => _selectedItem.value = '點選第三項',
            ),
          ],
      ).toList(),
      scrollDirection: Axis.vertical,);
    //   <Widget>[
    //     ListTile(
    //       title: const Text('第一項', style: TextStyle(fontSize: 20),),
    //       onTap: () => _selectedItem.value = '點選第一項',
    //     ),
    //     ListTile(
    //       title: const Text('第二項', style: TextStyle(fontSize: 20),),
    //       onTap: () => _selectedItem.value = '點選第二項',
    //     ),
    //     ListTile(
    //       title: const Text('第三項', style: TextStyle(fontSize: 20),),
    //       onTap: () => _selectedItem.value = '點選第三項',
    //     ),
    //   ],
    // );

    final widget = Container(
      child:Column(
        children: <Widget>[
          ValueListenableBuilder(
              valueListenable: _selectedItem,
              builder: _selectedItemBuilder),
          Expanded(child: listView,),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
    );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }

  //
  Widget _selectedItemBuilder(BuildContext context, String itemName, Widget? child){
    final widget = Text(itemName, style: const TextStyle(fontSize: 20));
    return widget;
  }
}