import 'package:shared_preferences/shared_preferences.dart';

class sharedpref{
  static Future<SharedPreferences> get _instance async => await SharedPreferences.getInstance();

  static SharedPreferences? _prefrence;

  static Future<SharedPreferences> init() async{
    _prefrence = await _instance;
    return _prefrence!;
  }

  setbool(String key,bool value)async{
    return _prefrence!.setBool(key, value);
  }
  getbool(String key,bool value){
    return _prefrence!.getBool(key)??false;
  }
  clearData() {
    return _prefrence!.clear();
  }
}
// chech(){
//   bool islogin=sh...getbool("",false)
//   if(islogin){
//   navi
//   }
//   setState(() {
//
//   });
// }


class shrepref{
  static Future<SharedPrefrence>
}