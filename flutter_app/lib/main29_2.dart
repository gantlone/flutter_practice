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

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  static const List<Tab> _tabs = [
    Tab(
      icon: Icon(Icons.directions_bike),
      text: 'Bike',
    ),
    Tab(
      icon: Icon(Icons.directions_car),
      text: 'Car',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: const Text('Tab標籤頁範例'),
      bottom: TabBar(  // TabController是App啟動後才建立，所以TabBar不能用const
        tabs: _tabs,
        controller: _tabController,
      ),
    );

    // 建立App的操作畫面
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
          color: Colors.black12,
        ),
      ],
      controller: _tabController,
    );

    // 結合AppBar和App操作畫面
    final appHomePage = DefaultTabController(
      length: tabBarView.children.length,
      child: Scaffold(
        appBar: appBar,
        body: tabBarView,
      ),
    );

    return appHomePage;
  }
}
