import 'package:flutter/material.dart';

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
  static const items = <String>['第一項', '第二項', '第87項', '我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原','我愛羅晟原',]; //ListView選項
  static const cities = ['北投', '圓山', '公館路']; //Radio選項
  final ValueNotifier<String> _selectedItem = ValueNotifier(''); //ListView被選項目
  final ValueNotifier<int?> _selectedCity = ValueNotifier(null); //Radio被選項目

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('Tab標籤頁範例', style: TextStyle(fontSize: 20),),
      bottom: const TabBar( //建立TabBar物件，把設定給AppBar的bottom參數
          tabs: [
            Tab(
              icon: Icon(Icons.directions_bike),
              text: 'Bike',
            ),
            Tab(
              icon: Icon(Icons.directions_car),
              text: 'Car',
            ),
          ]
      ),
    );

    //建立ListView
    final listView = ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) =>
          ListTile(title: Text(items[index], style: const TextStyle(fontSize: 20),),
            onTap: () => _selectedItem.value = '點選' + items[index],
            onLongPress: () => _selectedItem.value = '長按' + items[index],
          ),
      physics: const ClampingScrollPhysics(),
    );

    final tabPage1 = Container( //ListView內容
      child: Column(
        children: <Widget>[
          ValueListenableBuilder<String>(
              valueListenable: _selectedItem,
              builder: _selectedItemBuilder
          ),
          Expanded(child: listView)
        ],
      ),
      color: Colors.black26,
    );

    final tabPage2 = Center( //Radio內容
      child: Column(
        children: <Widget>[
          Container(
            child: ValueListenableBuilder<int?>(
                valueListenable: _selectedCity,
                builder: _cityOptionBuilder
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Container(
            child: ValueListenableBuilder<int?>(
              valueListenable: _selectedCity,
              builder: (context, value, child) {
                final selectedCity = value != null ? cities[value] : ''; // 提供一個默認值
                return Text(
                  selectedCity,
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
          )
        ],
      ),
    );

    //建立TabBarView物件，這個參數負責顯示AppBar每個頁籤的內容
    final tabBarView = TabBarView(
        children: [tabPage1, tabPage2],
        physics: const BouncingScrollPhysics(),
    );

    //結合AppBar和App操作畫面
    final appHomePage = DefaultTabController( //用DefaultTabController建立跟Tab相關的App畫面，通常與Scaffold一同使用
        length: tabBarView.children.length,
        child: Scaffold(
          appBar: appBar,
          body: tabBarView,
        ));

    return appHomePage;
  }

  //建立Text物件，顯示被點選的項目名稱
  Widget _selectedItemBuilder(BuildContext context, String itemName, Widget? child){
    final widget = Text(itemName,
      style: const TextStyle(fontSize: 20),
    );
    return widget;
  }

  //這方法用來建立Radio選單
  Widget _cityOptionBuilder(BuildContext context, int? selectedItem, Widget? child){
    var radioItems = <RadioListTile>[];

    //加入radioItems
    for (var i=0; i<cities.length; i++){
      radioItems.add(
        RadioListTile(
            value: i,
            groupValue: _selectedCity.value,
            onChanged: (value) => _selectedCity.value = value,
            title: Text(cities[i], style: const TextStyle(fontSize: 20),),
        )
      );
    }

    final wid = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radioItems,
    );

    return wid;
  }
}