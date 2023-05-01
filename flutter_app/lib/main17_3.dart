import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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
    final widget = ValueListenableBuilder<int>(
                builder: _imageBuilder,
                valueListenable: _imageIndex,
              );

    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }

  //這個方法會將圖片，轉換成實際Image物件，使用，PhotoView顯示，讓程式可以帶入
  Widget _imageBuilder(BuildContext context, int imageIndex, Widget? child) {
   var wid = Stack(
     alignment: Alignment.topCenter,
     children: <Widget>[
       PhotoViewGallery.builder(
         //設定滑動圖片的效果，BouncingScrollPhysics() = 滑到最後一項時會有回彈的效果
          scrollPhysics: const ClampingScrollPhysics(),
         //設定函數，用來顯示圖片
          builder: _buildItem, //呼叫_buildItem()顯示圖片
         //設定圖片數量
          itemCount: _images.length,
         //是否允許旋轉圖片
          enableRotation: true,
         //背景顏色
          backgroundDecoration: const BoxDecoration(color: Colors.white,),
         //設定從哪一張圖片開始
          pageController: PageController(initialPage: 0),
         //當圖片要切換時，呼叫此函數
          onPageChanged: _onPageChanged,
         //設定捲動方向，水平(horizontal)，垂直(vertical)
          scrollDirection: Axis.horizontal,
       ),
       Container(
         margin: const EdgeInsets.all(50.0),
         child: Text(
           "圖片 ${_imageIndex.value + 1}",
           style: const TextStyle(fontSize: 20),
         ),
       )
     ],
   );

   return wid;

  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      //設定要顯示的影像
        imageProvider: AssetImage(_images[index]),
      //設定影像初始放大倍率
        initialScale: PhotoViewComputedScale.contained,
      //設定影像最小倍率
        minScale: 0.6,
      //設定影像最大倍率
        maxScale: 1.2,
    );
  }

  void _onPageChanged(int index){
    _imageIndex.value = index;
  }

}