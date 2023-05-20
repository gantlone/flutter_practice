import 'package:flutter/material.dart';

import 'database/book.dart';
import 'database/book_db_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '資料庫範例'),
    );
  }
}

// 螢幕的虛擬鍵盤出現和消失時，App畫面會重建
// 為了讓App畫面記下最新的執行狀態，我們用StatefulWidget實作
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final bookTitleController = TextEditingController();
  final bookAuthorController = TextEditingController();
  final bookPublisherController = TextEditingController();
  final bookPriceController = TextEditingController();

  // 儲存要顯示的書籍資料
  final ValueNotifier<List<Book>> _booksNotifier = ValueNotifier(<Book>[]);

  @override
  void initState() {
    super.initState();

    _listAllBooks();
  }

  @override
  void dispose() {
    // State物件銷毀時必須清除相關物件
    bookTitleController.dispose();
    bookAuthorController.dispose();
    bookPublisherController.dispose();
    bookPriceController.dispose();
    _booksNotifier.dispose();

    BookDbHelper().closeDb();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 建立AppBar
    final appBar = AppBar(
      title: Text(widget.title),
    );

    // 建立App的操作畫面
    final bookTitle = TextField(
      controller: bookTitleController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        labelText: '書名',
        labelStyle: TextStyle(fontSize: 20),
      ),
    );

    final bookAuthor = TextField(
      controller: bookAuthorController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        labelText: '作者',
        labelStyle: TextStyle(fontSize: 20),
      ),
    );

    final bookPublisher = TextField(
      controller: bookPublisherController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        labelText: '出版商',
        labelStyle: TextStyle(fontSize: 20),
      ),
    );

    final bookPrice = TextField(
      controller: bookPriceController,
      style: const TextStyle(fontSize: 20),
      decoration: const InputDecoration(
        labelText: '售價',
        labelStyle: TextStyle(fontSize: 20),
      ),
    );

    final wid = Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9),
          child: Column(
            children: <Widget>[
              Container(child: bookTitle,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),),
              Container(child: bookAuthor,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),),
              Container(child: bookPublisher,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),),
              Container(child: bookPrice,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),),
              _buttonsPanel(),
              Expanded(
                child: ValueListenableBuilder<List<Book>>(
                  builder: _bookListBuilder,
                  valueListenable: _booksNotifier,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );

    // 結合AppBar和App操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: wid,
    );

    return appHomePage;
  }

  // 這個方法用來建立按鈕
  Widget _buttonsPanel() {
    final btnInsertBook = ElevatedButton(
        child: const Text(
          '加入',
          style: TextStyle(fontSize: 20, color: Colors.redAccent,),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.yellow,  // 按鈕背景色
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 8,
        ),
        onPressed: () {
          BookDbHelper().insertBook(
              Book(
                  bookTitleController.text,
                  bookAuthorController.text,
                  bookPublisherController.text,
                  int.parse(bookPriceController.text)
              )
          );

          _listAllBooks();
        }
    );

    final btnQueryBooks = ElevatedButton(
      child: const Text(
        '查詢',
        style: TextStyle(fontSize: 20, color: Colors.redAccent,),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.yellow,  // 按鈕背景色
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 8,
      ),
      onPressed: () {
        var futureAllBooks = BookDbHelper().queryBook(bookTitleController.text);

        futureAllBooks.then((books) {
          _booksNotifier.value = books;
        });
      },
    );

    final btnDeleteBook = ElevatedButton(
      child: const Text(
        '刪除',
        style: TextStyle(fontSize: 20, color: Colors.redAccent,),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.yellow,  // 按鈕背景色
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 8,
      ),
      onPressed: () {
        BookDbHelper().deleteBook(bookTitleController.text);

        _listAllBooks();
      },
    );

    var wid = Row(
      children: [
        Expanded(flex: 1,
          child: Container(
            child: btnInsertBook,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        Expanded(flex: 1,
          child: Container(
            child: btnQueryBooks,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        Expanded(flex: 1,
          child: Container(
            child: btnDeleteBook,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ],
    );

    return wid;
  }

  _listAllBooks() async {
    var futureAllBooks = BookDbHelper().allBooks();
    futureAllBooks.then((books) {
      _booksNotifier.value = books;
    });
  }

  Widget _bookListBuilder(BuildContext context, List<Book> books, Widget? child) {
    final listView = ListView.separated(
      itemCount: books.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(
              '${books[index].title}, ${books[index].author}, '
                  '${books[index].publisher}, ${books[index].price}',
              style: const TextStyle(fontSize: 20),
            ),
          ),
      separatorBuilder: (context, index) => const Divider(),
    );

    return Container(
      child: listView,
      margin: const EdgeInsets.symmetric(horizontal: 10),);
  }
}
