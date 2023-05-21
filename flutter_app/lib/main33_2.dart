import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

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
  //儲存進度
  final ValueNotifier<double> _progressValue =  ValueNotifier(0.0);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  bool _showProgress = false;

  @override
  Widget build(BuildContext context){

    //建立AppBar
    final appBar = AppBar(
      title: const Text('進度條範例'),
    );

    //建立App的操作畫面
    final btnStart = ElevatedButton(
        onPressed: () => _startProgress(context),
        child: const Text('開始', style: TextStyle(fontSize: 18),)
    );

    final wid = Center(
      child: btnStart,
      heightFactor: 3,
    );

    //結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: wid,
    );

    return appHomePage;
  }

  _startProgress(BuildContext context){
    _progressValue.value = 0.0; //讓進度從0開始
    _isLoading.value = true;
    _showProgress = true;

    showDialog(
        context: context,
        builder: (BuildContext context) =>
            StatefulBuilder(
                builder: (context, setState){
                  return WillPopScope(
                      child: Dialog(
                        child: Container(//進度條的大小
                            child: ValueListenableBuilder<double>(
                              builder: _progressBuilder,
                              valueListenable: _progressValue,
                            ),
                            width: 200,
                            height: 200,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                          ),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                        ),
                      ),
                      onWillPop: () async => false
                  );
                }
            )
    );

    // Timer.periodic(
    //   const Duration(milliseconds: 500),
    //     (timer){
    //     if (_progressValue.value >= 1){
    //       Navigator.pop(context);
    //     } else{
    //       _progressValue.value += 0.1;
    //     }
    //   }
    // );

    Timer.periodic(
      const Duration(milliseconds: 500),
          (timer) {
        if (_progressValue.value >= 1) {
          timer.cancel();
          _isLoading.value = false;
          _showProgress = false;
          Navigator.of(context).pop();//讀取完先行關閉讀取視窗

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('读取成功'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('确定'),
                  ),
                ],
              );
            },
          );
        } else {
          _progressValue.value += 0.1;
        }
      },
    );
  }

  //這個方法負責進度條
  Widget _progressBuilder(BuildContext context, double progressValue, Widget? child) {
    if(progressValue > 1) progressValue = 1;//為了處理電腦浮點數的誤差

    final widget = CircularPercentIndicator(
      radius: 50,
      lineWidth: 10.0, //字體高度
      percent: progressValue,
      center: Text('${(progressValue * 100).toStringAsFixed(0)}%', //顯示幾%
        style: const TextStyle(fontSize: 18, color: Colors.black)),
      progressColor: Colors.green,
    );

    return widget;
  }

}