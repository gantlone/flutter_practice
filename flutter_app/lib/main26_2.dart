import 'package:flutter/material.dart';
import 'package:flutter_app/main26_second_page.dart';

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
      //home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/second page' : (context) => SecondPage(),
      },

    );
  }
}

class SecondPageData{
  int? num;
  String? str;
  SecondPageData(this.num, this.str);
}

class MyHomePage extends StatelessWidget{
  final ValueNotifier<String> _inputName = ValueNotifier('');

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('切換畫面'),
    );

    //建立App的操作畫面
    final btn1 = ElevatedButton(
        child: const Text('開啟第二頁'),
        onPressed: () => showSecondPage(context));

    final nameController = TextEditingController();
    final txt = TextField(
      controller: nameController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        labelText: '輸入姓名',
        labelStyle: TextStyle(fontSize: 20),
      ),
    );

    final btn2 = ElevatedButton(
        onPressed: () => _inputName.value = nameController.text,
        child: const Text('打字'));

    final widget = Container(
      child: Column(children: <Widget>[
        Container(child: btn1, margin: const EdgeInsets.symmetric(vertical: 10)),
        Container(child: txt, width: 200, margin: const EdgeInsets.symmetric(vertical: 10)),
        Container(child: btn2, margin: const EdgeInsets.symmetric(vertical: 10)),
        Container(child: ValueListenableBuilder<String>(
          builder: _inputNameWidgetBuilder,
          valueListenable: _inputName,
        ))
      ]),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(30),
    );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),

    );

    return appHomePage;
  }

  Widget _inputNameWidgetBuilder(BuildContext context, String inputName, Widget? child){
    final widget = Text(inputName, style: const TextStyle(fontSize: 20),);
    return widget;
  }

  showSecondPage(BuildContext context,) async {
    final result = (await Navigator.pushNamed(
      context, '/second page', arguments: SecondPageData(10, '顯示第二頁')
    )) as FirstPageData;

    int num = result.num;
    String str = result.str;
  }
}