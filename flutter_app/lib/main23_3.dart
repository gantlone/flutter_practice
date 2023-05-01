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
    const items = <String>['第一項', '第二項', '第三項'];
    const icons = <String>['assets/1.jpg', 'assets/1.jpg', 'assets/1.jpg'];

    //建立AppBar
    final appBar = AppBar(
      title: const Text('ListView範例'),
    );

    //建立App的操作畫面
    var listView = ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) =>
            ListTile(
              title: Text(items[index], style: TextStyle(fontSize: 20),),
              subtitle: Text(items[index], style: TextStyle(fontSize: 10),),
              onTap: () => index == 0 ? _selectedItem.value = '我愛羅晟原' : _selectedItem.value = '點選' + items[index],
              onLongPress: () => index == 0 ? _selectedItem.value = '最愛羅晟原' : _selectedItem.value = '點選' + items[index],
              leading: Container(
                child: Image.asset(icons[index],),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),),
              trailing: const Icon(Icons.keyboard_alt_sharp),
            ),
        separatorBuilder: (BuildContext context, int index) {return const Divider();},
    );

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