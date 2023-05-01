import 'package:flutter/material.dart';


void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  //要顯示的選項
  static const _hobbies = <String>['看阿傑', '跟棉被玩', '看甲甲區', '打遊戲王', '尻尻', '我愛羅晟原',
    "\u2764", '\u{1F601}', '\u{1F60A}', '\u{1F60A}', '\u{1F60A}', '\u{1F60A}', '\u{1F60A}', '\u{1F60A}',
  '\u{1F970}','\u{1F970}','\u{1F970}','\u{1F970}','\u{1F970}'];

  //記錄每一個選項是否被勾選，預設全部沒勾選(false)
  final ValueNotifier<List<bool>> _hobbiesSelected = ValueNotifier(List<bool>.generate(_hobbies.length, (int index) => false));

  //顯示結果
  final ValueNotifier<String> _text = ValueNotifier('阿傑寶');


  @override
  Widget build(BuildContext context) {
    //建立 AppBar
    final appBar = AppBar(
      title: const Text('選擇興趣'),
    );

    final btn = ElevatedButton(
        onPressed: () => _showHobbies(), // 按下按鈕後呼叫_showHobbies()方法，將結果打印至螢幕上
        child: const Text('確定'));

    final widget = Center(
        child: SingleChildScrollView(  // 滾動checkbox頁面
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  child: ValueListenableBuilder<List<bool>>( //ValueListenableBuilder用法是當checkbox變動時，可以更新UI介面
                    builder: _hobbySelectionBuilder,
                    valueListenable: _hobbiesSelected,
                  ),
                  width: 200,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              Container(
                child: btn,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              Container(
                child: ValueListenableBuilder<String>(
                  builder: _textWidgetBuilder,
                  valueListenable: _text,
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
            ],
          ),
        )
    );

    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;

  }

  //此方法用來建立選單
  Widget _hobbySelectionBuilder(BuildContext context, List<bool> hobbiesSelected, Widget? child){
    List<CheckboxListTile> checkboxes = [];

    // 把選項加入Checkbox list
    for (var i = 0; i < _hobbies.length; i++) {
      checkboxes.add(
          CheckboxListTile(
            title: Text(_hobbies[i], style: const TextStyle(fontSize: 20)),
            value: _hobbiesSelected.value[i],
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (newValue) {
              _hobbiesSelected.value[i] = newValue as bool;

              // 要做一個新的List給ValueNotifier才會啟動重建
              _hobbiesSelected.value = List.from(_hobbiesSelected.value);
            },
          )
      );
    }

    final wid = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: checkboxes,
    );

    return wid;

  }

  Widget _textWidgetBuilder(BuildContext context, String text, Widget? child) {
    final wid = Text(text,
        style: const TextStyle(fontSize: 20));
    return wid;
  }

  _showHobbies() {
    String selectedHobbies = '';
    for (int i = 0; i < _hobbiesSelected.value.length; i++) {
      if (_hobbiesSelected.value[i]) selectedHobbies += _hobbies[i];
    }
    _text.value = selectedHobbies;
  }
}
