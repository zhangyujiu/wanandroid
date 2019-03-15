
import 'package:intl/intl.dart';

class TimeUtils{
  ///format:时间格式  yyyy-MM-dd
 static String getCurrentDate({String format="yyyy-MM-dd"}){
    var now = new DateTime.now();
    var formatter = new DateFormat(format);
    String formatted = formatter.format(now);
    return formatted;
  }
}
