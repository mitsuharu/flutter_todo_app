import 'package:intl/intl.dart';

class Util{

  static DateFormat _dateFormat(){
    var format = new DateFormat.yMd().add_Hms();
    return format;
  }

  static String date2string(DateTime date){
    var format = Util._dateFormat();
    var str = format.format(date);
    return str;
  }

  static DateTime string2date(String str){
    var format = Util._dateFormat();
    return format.parse(str);
  }

}