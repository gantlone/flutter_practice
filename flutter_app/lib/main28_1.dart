import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //建立AppBar
    final appBar = AppBar(
      title: const Text('AppBar 範例'),
      centerTitle: true,
      backgroundColor: Colors.orange,
      elevation: 10,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );

    // final appBar = AppBar(
    //   title: const Text('AppBar 範例'),
    //   centerTitle: false,
    //   backgroundColor: Colors.brown,
    //   elevation: 5,
    //   systemOverlayStyle: SystemUiOverlayStyle.dark,
    // );


    final appHomePage = Scaffold(
      appBar: appBar,
      //body: widget,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: appHomePage,

    );
  }
}