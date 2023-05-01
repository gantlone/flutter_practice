//Person 類別
class Person{
  //late String name;
  final String name;           //改動1，將變數宣告改成final

  //Person(String name){
  //this.name = name;
  //}
  const Person(this.name);    //改動2，const建構式

  // void setName(String name){
  //   this.name = name;
  // }

  String getName(){
    return name;
  }
}

//Student 類別
class Student extends Person{
  late int score;

  //super表示將父類別中的name傳過來使用
  Student(String name, int score) : super(name){
    this.score = score;
  }

  void setScore(int score){
    this.score = score;
  }

  int getScore(){
    return score;
  }
}

//主程式
void main(){
  Person p = const Person('阿鵝');
  Student s = Student('阿揚',55);
  p.getName();
  s.setScore(66);
}