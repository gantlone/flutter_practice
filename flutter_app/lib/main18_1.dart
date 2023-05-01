import 'dart:io';

printWithTimestamp(String str){
  var now = DateTime.now();
  print('${now.hour}:${now.minute}:${now.second} $str');
}

Future<int> doAsyncJob() async{
  //'讓程式停3秒鐘
  await Future.delayed(const Duration(seconds: 3));
  printWithTimestamp('doJob() 結束');
  return 0;
}

void main(){
  printWithTimestamp('程式啟動');

  //用Future物件進入非同步執行模式，用then()來回收其傳回值
  var futureResult = doAsyncJob();
  futureResult.then((value) => printWithTimestamp('doJob() 傳回$value'));

  printWithTimestamp('程式結束');

}