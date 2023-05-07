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

    //建立TabBarView物件，這個參數負責顯示AppBar每個頁籤的內容
    final tabBarView = TabBarView(
        children: [
          Container(
            child: const Text('Bike page', style: TextStyle(fontSize: 20),),
            alignment: Alignment.center,
            color: Colors.black26,
          ),
          Container(
            child: const Text('Car page', style: TextStyle(fontSize: 20),),
            alignment: Alignment.center,
            color: Colors.black26,
          ),
        ]
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
}