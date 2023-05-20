class Book {

  //書籍資料儲存在資料表的欄位名稱(Key)
  static const bookTitle = 'title',
              bookAuthor = 'author',
              bookPublisher = 'publisher',
              bookPrice = 'price';

  final String title;
  final String author;
  final String publisher;
  final int price;

  //建構子，把傳入的書籍資料存入類別內部的物件
  Book(this.title, this.author, this.publisher, this.price);

  //把書籍資料寫入資料庫時的方法(Value)
  Map<String, dynamic> toMap(){
    return{
      bookTitle: title,
      bookAuthor: author,
      bookPublisher: publisher,
      bookPrice: price
    };
  }
}