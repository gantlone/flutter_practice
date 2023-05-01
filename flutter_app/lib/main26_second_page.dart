import 'package:flutter/material.dart';
import 'package:flutter_app/main26_2.dart';

class SecondPage extends StatelessWidget{
  SecondPageData? _data;

  SecondPage({super.key});

  @override
  Widget build(BuildContext context){
    if (_data == null){
      //取得傳送資料
      _data = ModalRoute.of(context)?.settings.arguments as SecondPageData?;
      int? num = _data?.num;
      String? str = _data?.str;
    }
    //SecondPageData? data = ModalRoute.of(context)?.settings.arguments as SecondPageData?;
    //建立AppBar
    final appBar = AppBar(
      title: const Text('第二頁'),
    );

    //建立App的操作畫面
    final btn = ElevatedButton(
        onPressed: () => Navigator.pop(context, FirstPageData(50, '回到第一頁')) as SecondPageData,
        child: const Text('回上一頁'));

    final widget = Container(
      child: btn,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(30),
    );

    final page = Scaffold(
      appBar: appBar,
      body: widget,
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),

    );

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          Navigator.pop(context);
        }
      },
      child: page,
    );
  }
}

class FirstPageData{
  int num;
  String str;
  FirstPageData(this.num, this.str);
}