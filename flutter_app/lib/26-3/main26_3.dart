import 'package:flutter/material.dart';
import 'package:flutter_app/26-3/select_drink.dart';
import 'package:flutter_app/26-3/select_main_course.dart';

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
      // home: MyHomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/26-3/second main course' : (context) => SelectMainCourse(),
        '/26-3/second drink' : (context) => SelectDrink(),
      },

    );
  }
}

class MyHomePage extends StatelessWidget{
  final ValueNotifier<String> _selectedMainCourse = ValueNotifier('');
  final ValueNotifier<String> _selectedDrink = ValueNotifier('');

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('切換畫面'),
    );

    //建立App的操作畫面
    final btnSelectMainCourse = ElevatedButton(
        child: const Text('選擇主餐', style: TextStyle(fontSize: 20, color: Colors.red),),
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          elevation: 8
        ),
        onPressed: () {
          //切換到選擇主餐畫面
          _showMainCourseScreen(context);
        }
    );

    final btnSelectDrink = ElevatedButton(
        child: const Text('選擇飲料', style: TextStyle(fontSize: 20, color: Colors.red),),
        style: ElevatedButton.styleFrom(
            primary: Colors.yellow,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            elevation: 8
        ),
        onPressed: () {
          //切換到選擇飲料畫面
          _showDrinkScreen(context);
        }
    );

    final row1 = Row(
      children: <Widget>[
        Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: ValueListenableBuilder<String>(
                builder: _selectedMainCourseBuilder,
                valueListenable: _selectedMainCourse,
              ),
        )),
        Container(
          child: btnSelectMainCourse,
          margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        )
      ],
    );

    final row2 = Row(
      children: <Widget>[
        Expanded(
            child: Container(
              child: ValueListenableBuilder<String>(
                builder: _selectedDrinkBuilder,
                valueListenable: _selectedDrink,
              ),
              margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            )),
        Container(
          child: btnSelectDrink,
          margin: const EdgeInsets.fromLTRB(15, 8, 15, 8),
        )
      ],
    );

    final widget = Column(
      children: <Widget>[row1, row2],
    );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }

  Widget _selectedMainCourseBuilder(BuildContext context, String mainCourse, Widget? child){
    final widget = Text(mainCourse, style: const TextStyle(fontSize: 20),);
    return widget;
  }

  Widget _selectedDrinkBuilder(BuildContext context, String drink, Widget? child){
    final widget = Text(drink, style: const TextStyle(fontSize: 20),);
    return widget;
  }

  _showMainCourseScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/26-3/second main course');
    if(result != null) _selectedMainCourse.value = result.toString();
    else _selectedMainCourse.value = '沒有選擇';
  }

  _showDrinkScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/26-3/second drink');
    if(result != null) _selectedDrink.value = result.toString();
    else _selectedDrink.value = '沒有選擇';
  }
}