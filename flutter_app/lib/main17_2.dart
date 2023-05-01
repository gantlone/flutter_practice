import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我愛阿傑寶\u{1F970}\u{1F970}\u{1F970}',
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  final  ValueNotifier<int> _imageIndex = ValueNotifier(1);

  static const _images = <String>['assets/1.jpg','assets/2.jpg','assets/3.jpg'];

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('阿傑照片合集'),
    );

    //建立App的操作畫面
    final previousBtn = IconButton(
        onPressed: () => _previousImage(),
        icon: Image.asset('assets/previous.png'),
        iconSize: 40);

    final nextBtn = IconButton(
        onPressed: () => _nextImage(),
        icon: Image.asset('assets/next.png'),
        iconSize: 40);

    final widget = Center(
      child: Stack(
        children: <Widget>[
          Container(
            //用ValueListenableBuilder 把_ImageIndex 和 _imageBuilder()
            //結合起來，這樣當_ImageIndex被修改，就會觸發_imageBuilder()
              child: ValueListenableBuilder<int>(
                builder: _imageBuilder,
                valueListenable: _imageIndex,
              ),
              margin: const EdgeInsets.symmetric(vertical: 10)
          ),
          Container(
              child: Row(
                children: <Widget>[previousBtn, nextBtn],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              margin: const EdgeInsets.symmetric(vertical: 10)
          ),
        ],
        alignment: Alignment.topCenter,
      ),
    );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }

  //這個方法會將圖片，轉換成實際Image物件，使用，PhotoView顯示，讓程式可以帶入
  Widget _imageBuilder(BuildContext context, int imageIndex, Widget? child) {
    var img = PhotoView(
      //設定要顯示的影像
        imageProvider: AssetImage(_images[_imageIndex.value]),
      //設定影像最小倍率
        minScale: PhotoViewComputedScale.contained * 0.6,
      //設定影像最大倍率
        maxScale: PhotoViewComputedScale.covered,
      //是否允許旋轉影像
        enableRotation: true,
      //設定PhoteView背景顏色
        backgroundDecoration: const BoxDecoration(
          color: Colors.pink
        ),
    );
    return img;
  }

  //三目運算式
  //這是類似於if else的判斷式
  // 如果=0，_images.length - 1，就是最後一張圖片
  // 其他不等於0，_imageIndex.value - 1，往前一張圖片
  _previousImage(){
    _imageIndex.value =
    _imageIndex.value == 0 ? _images.length - 1 : _imageIndex.value - 1;
  }

  //利用餘數的方式，如果該值+1後可以被整除，就等於又回歸第一張圖片
  _nextImage(){
    _imageIndex.value = ++ _imageIndex.value % _images.length;
  }
}