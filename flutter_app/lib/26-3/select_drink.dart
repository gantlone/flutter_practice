import 'package:flutter/material.dart';

import 'data.dart';

class SelectDrink extends StatelessWidget {

  final _drink = ['紅茶', '泡沫綠茶'];
  final ValueNotifier<int?> _selectedItem = ValueNotifier(Data.drinkItem);

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: const Text('選擇飲料'),
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
              builder: _drinkOptionBuilder,
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

  Widget _drinkOptionBuilder(BuildContext context, int? selectedItem, Widget? child) {
    var radioItems = <RadioListTile>[];

    // 把選項加入radioItems
    for (var i = 0; i < _drink.length; i++) {
      radioItems.add(
          RadioListTile(
            value: i,
            groupValue: selectedItem,
            title: Text(_drink[i], style: const TextStyle(fontSize: 20),),
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
    Data.drinkItem = _selectedItem.value;
    String? drink = Data.drinkItem != null ?
    _drink[Data.drinkItem!] : null;
    Navigator.pop(context, drink);
  }
}