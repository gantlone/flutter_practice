import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我愛阿傑寶😍😍😍',
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //建立AppBar
    final appBar = AppBar(
      title: const Text('GridView😀😍'),
    );

    const items = <String>['第一項','第一項','第一項','第一項','第一項','第一項','第一項','第一項','第一項','第一項',];

    final widget = GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      padding: EdgeInsets.all(20.0),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      physics: ClampingScrollPhysics(),
      children: List.generate(items.length,
              (index) {
                final widget =
                Container(
                  child: Text(items[index], style: TextStyle(fontSize: 20)),
                  alignment: Alignment.center,
                  color: Colors.black12);
                return widget;
              }),
    );

    //結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }
}