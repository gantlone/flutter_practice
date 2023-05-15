import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesHelper{

  static const _key_name = 'name'; //儲存姓名的Key

  static final SharePreferencesHelper _sharePreferencesHelper =
  SharePreferencesHelper._privConstructor();

  factory SharePreferencesHelper() => _sharePreferencesHelper;

  SharePreferencesHelper._privConstructor();

  //儲存姓名的方法，非同步方式執行
  saveName(String name) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(_key_name, name);
  }

  //讀取姓名的方法，非同步方法執行
  readName() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('name') ?? '';
  }
}