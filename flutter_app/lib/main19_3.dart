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
      title: '我愛阿傑寶😍😍😍',
      theme: ThemeData(
          primarySwatch: Colors.pink
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  //圖片庫路徑
  final ValueNotifier<List<XFile>?> _imageFiles = ValueNotifier(null);
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
      onPressed: () => _takepictures(), //用拍照模式啟動ImagePicker
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
      onPressed: () => _selectImage(),
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
              child: ValueListenableBuilder<List<XFile>?>(
                builder: _imageBuilder,
                valueListenable: _imageFiles,
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
  Future<void> _takepictures() async{
    XFile? photo = await _imagePicker.pickImage(source: ImageSource.camera);
    List<XFile>? imgFiles = photo == null ? null : <XFile>[photo];
    _imageFiles.value = imgFiles;//把選擇的照片們存入_imageFiles
  }

  Future<void> _selectImage() async{
    List<XFile>? imgFiles = await _imagePicker.pickMultiImage(); //使用pickMultiImage()選取多重照片
    _imageFiles.value = imgFiles;//把選擇的照片們存入_imageFiles
  }

  Widget _imageBuilder(BuildContext context, List<XFile>? imageFiles, Widget? child){
    //如果imageFile = null，就提示沒有照片，否則用Image物件顯示照片
    final wid = imageFiles == null ? const Text('沒有照片', style: TextStyle(fontSize: 20),) : _gridViewBuilder(imageFiles);
    return wid;
  }

  GridView _gridViewBuilder(List<XFile> imageFiles){
    final gridView = GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      padding: const EdgeInsets.all(20.0),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      physics: const BouncingScrollPhysics(),
      children: List.generate(
          imageFiles.length,
              (index) {
                final item = Semantics(
                  label: imageFiles[index].name,
                  child: Image.file(File(imageFiles[index].path), fit: BoxFit.contain));
                return item;
              }),
    );
      return gridView;

  }

}