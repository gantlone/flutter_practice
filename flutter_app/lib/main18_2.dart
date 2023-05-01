import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

class MyHomePage extends StatelessWidget {

  //圖片庫路徑
  final ValueNotifier<XFile?> _imageFile = ValueNotifier(null);
  //第三方庫提供，圖片選擇器
  final ImagePicker _imagePicker = ImagePicker(); //建立ImagePicker物件

  @override
  Widget build(BuildContext context){
    //建立AppBar
    final appBar = AppBar(
      title: const Text('挑選照片'),
    );

    //建立App操作畫面
    final btnCameraImage = ElevatedButton(
        onPressed: () => _getImage(ImageSource.camera), //用拍照模式啟動ImagePicker
        child: const Text(
          '相機拍照',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
        ),
    );

    final btnGalleryImage = ElevatedButton(
        onPressed: () => _getImage(ImageSource.gallery),
        child: const Text(
          '瀏覽相簿',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
    );

    final widget = Center(
      child: Column(
        children: <Widget>[
          Container(
            child: btnCameraImage,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Container(
            child: btnGalleryImage,
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Expanded(
            child: ValueListenableBuilder<XFile?>(
              builder: _imageBuilder,
              valueListenable: _imageFile,
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.start,
      )
    );

    //結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );

    return appHomePage;
  }

  //非同步函數
  Future<void> _getImage(ImageSource imageSource) async {
    XFile? imgFile = await _imagePicker.pickImage(source: imageSource);
    _imageFile.value = imgFile; //把選擇的照片存入_imageFile
  }

  Widget _imageBuilder(BuildContext context, XFile? imageFile, Widget? child){
    //如果imageFile = null，就提示沒有照片，否則用Image物件顯示照片
    final wid = imageFile == null ? const Text('沒有照片', style: TextStyle(fontSize: 20),) : Image.file(File(imageFile.path), fit: BoxFit.contain,);
    return wid;
  }
}