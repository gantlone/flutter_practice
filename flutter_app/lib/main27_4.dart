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
  //要顯示的城市清單
  static const _citites = ['倫敦', '圓山', '北投'];

  final ValueNotifier<String> _dlgResult = ValueNotifier('');
  final ValueNotifier<int?> _selectedCity = ValueNotifier(null);

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

    final widget = Center(
        child: Column(
          children: <Widget>[
            Container(
              child: btn,
              margin: const EdgeInsets.symmetric(vertical: 10),
            ),
            Container(
              child: ValueListenableBuilder<String>(
                builder: _showDlgResult,
                valueListenable: _dlgResult,
              ),
            )
          ],
        )
    );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }

  _showDialog(BuildContext context) async {
    final btnOk = ElevatedButton(
        child: const Text(
          'ok', style: TextStyle(fontSize: 20),),
        onPressed: () {
          Navigator.pop(context,
              _selectedCity.value == null ? '' : _citites[_selectedCity.value!]);
        }
    );

    final btnCancel = ElevatedButton(
        child: const Text(
          'no', style: TextStyle(fontSize: 20),),
        onPressed: () {
          Navigator.pop(context, '');
        }
    );

    final btns = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 5, 5),
            child: btnOk,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 5, 5),
            child: btnCancel,
          ),
        ),
      ],
    );

    var dlg = Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ValueListenableBuilder(
              valueListenable: _selectedCity,
              builder: _cityOptionsBuilder),
          btns
        ],
      ),
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    );

    var willPopScope = WillPopScope(
        child: dlg,
        onWillPop: () async => false
    );

    var ans = showDialog(context: context, builder: (context) => willPopScope);
    return ans;
  }

  Widget _showDlgResult(BuildContext context, String result, Widget? child){
    final widget = Text(
      result,
      style: const TextStyle(fontSize: 20),
    );
    return widget;
  }

  Widget _cityOptionsBuilder(BuildContext context, int? selectedItem, Widget? child){
    var radioItems = <RadioListTile>[];

    //把選項加入radioItems
    for (var i = 0; i < _citites.length; i++){
      radioItems.add(
          RadioListTile(
            value: i,
            groupValue: selectedItem,
            onChanged: (value) => _selectedCity.value = value,
            title: Text(_citites[i], style: const TextStyle(fontSize: 20),),
          )
      );
    }

    final wid = Column(
      mainAxisSize: MainAxisSize.min,
      children: radioItems,
    );

    return wid;
  }
}

