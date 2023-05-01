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
    var dig = AlertDialog(
        content: ValueListenableBuilder<int?>(
        builder: _cityOptionsBuilder,
        valueListenable: _selectedCity
        ),
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      contentTextStyle: const TextStyle(color: Colors.indigo, fontSize: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), //框框消邊
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context, _selectedCity.value == null ? '' : _citites[_selectedCity.value!]);
            },
            child: const Text('是')),
        TextButton(
            onPressed: () {
              Navigator.pop(context, '');
            },
            child: const Text('否')),
      ],
    );

    var ans = showDialog(context: context, builder: (context) => dig);
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

