import 'package:flutter_app/database/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BookDbHelper{

  //資料庫檔案名稱和表格名稱
  static const _bookDbName = 'book_db.db',
              _bookTableName = 'books';

  //用私有物件搭配getter檢查資料庫，並視情況開啟
  static Database? _database;
  Future<Database> get database async => _database ??= await _openDb();

  //用私有建構子和factory建構子實現Singleton
  static final BookDbHelper _booKDbHelper =
  BookDbHelper._privConstructor();
  factory BookDbHelper() => _booKDbHelper; //factory 建構子
  BookDbHelper._privConstructor(); //私有建構子

  //開啟書籍資料庫，如果不存在會自動建立
  static Future<Database> _openDb() async {
    //資料庫路徑
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, _bookDbName);

    //開啟資料庫，如果資料庫不存在則建立他，並產生表格
    var db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          db.execute(
            'CREATE TABLE $_bookTableName(id INTEGER PRIMARY KEY, '
                '${Book.bookTitle} TEXT, ${Book.bookAuthor} TEXT, '
                '${Book.bookPublisher} TEXT, ${Book.bookPrice} INTEGER)'
          );
        }
    );

    return db;
  }

  //關閉資料庫
  closeDb() async{
    final db = await database;//用getter取得資料庫
    await db.close();
  }

  //寫入資料庫
  insertBook(Book book) async {
    final db = await database;// 用getter取得資料庫
    await db.insert(
        _bookTableName, book.toMap(),
        conflictAlgorithm:  ConflictAlgorithm.replace, //發生衝突時，選擇替換最新的資料
    );
  }

  //查詢資料庫
  Future<List<Book>> queryBook(String bookTitle) async {
    final db = await database;// 用getter取得資料庫

    //用書名查詢書籍，資料庫查完傳回Map
    final List<Map<String, dynamic>>? mapBooks =
        await db.query(
          _bookTableName,
          columns: [Book.bookTitle, Book.bookAuthor, Book.bookPublisher, Book.bookPrice],
          where: '${Book.bookTitle} = ?',
          whereArgs: [bookTitle],
        );

    return  _mapBookToList(mapBooks); //把Map轉化成List
  }

  //從資料庫刪除書籍資料
  deleteBook(String bookTitle) async {
    final db = await database;// 用getter取得資料庫
    await db.delete(
      _bookTableName,
      where: '${Book.bookTitle} = ?',
      whereArgs: [bookTitle],
    );
  }

  //從資料庫取得全部書籍資料
  Future<List<Book>> allBooks() async {
    final db = await database;// 用getter取得資料庫

    //用書名查詢書籍，資料庫查完傳回Map
    final List<Map<String, dynamic>>? mapBooks =
    await db.query(_bookTableName);

    return  _mapBookToList(mapBooks); //把Map轉化成List
  }

  //把查詢資料庫得到的Map轉化成List
  List<Book> _mapBookToList(List<Map<String, dynamic>>? mapBooks){
    //取出Map裡面的資料，產生一個新的Book資料組
    var books = List.generate(
        mapBooks?.length ?? 0, //當為null時給0
            (i) => Book(
                mapBooks?[i][Book.bookTitle],
                mapBooks?[i][Book.bookAuthor],
                mapBooks?[i][Book.bookPublisher],
                mapBooks?[i][Book.bookPrice]
            )
    );

    return books;
  }
}