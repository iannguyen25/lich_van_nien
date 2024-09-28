import 'package:intl/intl.dart';

class DateUtils {
  // Định dạng ngày tháng năm theo dd/MM/yyyy
  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  // Tính khoảng cách giữa 2 ngày
  static int daysBetween(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }

  // Chuyển đổi Datetime sang dạng chuỗi yyyy-MM-dd
  static String toIsoFormat(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
