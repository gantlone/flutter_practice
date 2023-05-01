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

class MyHomePage extends StatelessWidget {

  //紀錄被點選的項目名稱
  final ValueNotifier<List<String>> _listItems = ValueNotifier(<String>['1','2','3']);

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('ListView範例'),
    );

    //建立App的操作畫面
    var items = <String>['1', '2', '3',];
    var itemLastNum = items.length;
    final GlobalKey<AnimatedListState> itemMenuKey = GlobalKey();

    final widget = AnimatedList(
        key: itemMenuKey,
        initialItemCount: items.length,
        itemBuilder: (context, index, animation) =>
            SizeTransition(
              sizeFactor: animation,
              child: ListTile(title: Text(items[index], style: const TextStyle(fontSize: 20),),
                onTap: () {
                  items.add((++itemLastNum).toString());
                  itemMenuKey.currentState?.insertItem(items.length - 1);
                },
                onLongPress: () {
                  var removedItem = items.removeAt(index);
                  var builder = (context, animation) =>
                      SizeTransition(
                        sizeFactor: animation,
                        child: ListTile(
                          title: Text(removedItem, style: TextStyle(fontSize: 20),),
                        ),
                      );
                  itemMenuKey.currentState?.removeItem(index, builder);
                },
              ),
            )
    );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }

  //
  Widget _listViewBuilder(BuildContext context, List<String> listItems, Widget? child){
    final listView = ListView.separated(
      itemCount: listItems.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(listItems[index], style: const TextStyle(fontSize: 20),),
            onTap: () {
              _listItems.value.add((_listItems.value.length + 1).toString());
              _listItems.value = List.from(_listItems.value);
            },
            onLongPress: () {
              _listItems.value.remove((_listItems.value.length - 1).toString());
              _listItems.value = List.from(_listItems.value);
            },
          ),
      separatorBuilder: (context, index) => const Divider(),
    );
    return listView;
  }
}