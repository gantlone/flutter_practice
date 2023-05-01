import 'package:flutter/material.dart';

import 'data.dart';

class SelectMainCourse extends StatelessWidget {

  final _mainCourses = ['牛肉麵', '排骨飯', '魚排飯'];
  final ValueNotifier<int?> _selectedItem = ValueNotifier(Data.mainCourseItem);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: const Text('選擇主餐'),
    );

    final btn = ElevatedButton(
      child: const Text('確定'),
      onPressed: () => _backToHomePage(context),
    );

    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(
            child: ValueListenableBuilder<int?>(
              builder: _mainCourseOptionBuilder,
              valueListenable: _selectedItem,
            ),
            width: 200,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Container(
            child: btn,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );

    // 結合AppBar和App操作畫面
    final page = Scaffold(
      appBar: appBar,
      body: widget,
    );

    var willPopScope = WillPopScope(
      onWillPop: () => _backToHomePage(context),
      child: page,
    );

    return willPopScope;
  }

  Widget _mainCourseOptionBuilder(BuildContext context, int? selectedItem, Widget? child) {
    var radioItems = <RadioListTile>[];

    // 把選項加入radioItems
    for (var i = 0; i < _mainCourses.length; i++) {
      radioItems.add(
          RadioListTile(
            value: i,
            groupValue: selectedItem,
            title: Text(_mainCourses[i], style: const TextStyle(fontSize: 20),),
            onChanged: (value) => _selectedItem.value = value,
          )
      );
    }

    final wid = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radioItems,
    );

    return wid;
  }

  _backToHomePage(BuildContext context) {
    Data.mainCourseItem = _selectedItem.value;
    String? mainCourse = Data.mainCourseItem != null ?
    _mainCourses[Data.mainCourseItem!] : null;
    Navigator.pop(context, mainCourse);
  }
}