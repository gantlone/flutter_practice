import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 建立appTitle物件
    var appTitle = const Text('Flutter App');

    // 建立appBody物件
    var appBody = AppBody();

    // 建立appBar物件
    var appBar = AppBar(
      title: appTitle,
    );

    // 建立app物件
    var app = MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: appBody,
      ),
    );

    return app;
  }
}

class AppBody extends StatelessWidget{

  final ValueNotifier<int> _age = ValueNotifier(20);
  static const int _maxAge = 100, _minAge = -10;

  AppBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final widget = ValueListenableBuilder<int>(
      builder: _agePickerBuilder,
      valueListenable: _age,
    );

    return widget;
  }

  Widget _agePickerBuilder(BuildContext context, int selectedAge, Widget? child){
    final wid = NumberPicker(
        minValue: _minAge,
        maxValue: _maxAge,
        step: 3,
        axis: Axis.horizontal,
        value: selectedAge,
        onChanged: (newValue) => _age.value = newValue);

    return wid;
  }
}