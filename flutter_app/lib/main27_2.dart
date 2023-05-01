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
  final ValueNotifier<int?> _dlgResult = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    //建立AppBar
    final appBar = AppBar(
      title: const Text('對話盒範例'),
    );

    //建立App的操作畫面
    final btn = ElevatedButton(
        child: const Text(
          ' 顯示對話盒', style: TextStyle(fontSize: 20),),
        onPressed: () async {
          //切換到選擇主餐畫面
          var ans = await _showDialog(context);
          _dlgResult.value = ans;
        }
    );

    final widget =
    Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: btn,
    );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }
}

_showDialog(BuildContext context) async {
  var dig = SimpleDialog(
    title: const Text('對話盒標題'),
    contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), //框框消邊
    children: <Widget>[
      SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, 1);
          },
          child: const Text('是')),
      SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, 0);
          },
          child: const Text('否')),
      SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, -1);
          },
          child: const Text('取消')),
    ],
  );

  var ans = showDialog(context: context, builder: (context) => dig);
  return ans;
}