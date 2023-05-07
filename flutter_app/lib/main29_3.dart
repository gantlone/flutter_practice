import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

  // BottomNavigationBar顯示的圖示和文字
  static const _naviItemIcon = [
    Icon(Icons.phone),
    Icon(Icons.email),
    Icon(Icons.message),
  ];
  static const _naviItemText = [
    'Phone',
    'Email',
    'Line'
  ];

  // 記錄BottomNavigationBar被點選的按鈕
  final ValueNotifier<int> _selectedNaviItem = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: const Text('Tab標籤頁範例'),
      bottom: const TabBar(
        tabs: [
          Tab(
            icon: Icon(Icons.directions_bike),
            text: 'Bike',
          ),
          Tab(
            icon: Icon(Icons.directions_car),
            text: 'Car',
          ),
        ],
      ),
    );

    // 建立App的操作畫面
    final tabBarView = TabBarView(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: _selectedNaviItem,
          builder: (context, value, child) => Container(
            child: Text('Bike page $value', style: TextStyle(fontSize: 20),),
            alignment: Alignment.center,
            color: Colors.black26,
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: _selectedNaviItem,
          builder: (context, value, child) => Container(
            child: Text('Car page $value', style: TextStyle(fontSize: 20),),
            alignment: Alignment.center,
            color: Colors.black26,
          ),
        ),
      ],
    );

    // 結合AppBar和App操作畫面
    final appHomePage = DefaultTabController(
      length: tabBarView.children.length,
      child: Scaffold(
        appBar: appBar,
        body: tabBarView,
        bottomNavigationBar: ValueListenableBuilder<int>(
          builder: _bottomNavigationBarBuilder,
          valueListenable: _selectedNaviItem,
        ),
      ),
    );

    return appHomePage;
  }

  // 這個方法負責建立BottomNavigationBar
  Widget _bottomNavigationBarBuilder(BuildContext context, int selectedButton, Widget? child) {
    final bottomNaviBarItems = <BottomNavigationBarItem>[];

    for (var i = 0; i < _naviItemIcon.length; i++) {
      bottomNaviBarItems.add(
        BottomNavigationBarItem(
            icon: _naviItemIcon[i],
            label: _naviItemText[i]),
      );
    }

    final widget = BottomNavigationBar(
      items: bottomNaviBarItems,
      currentIndex: _selectedNaviItem.value,
      onTap: (index) => _selectedNaviItem.value = index,
    );

    return widget;
  }
}
