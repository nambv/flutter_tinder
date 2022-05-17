import 'package:intl/intl.dart';

class DateUtil {
  static String? formatDate(DateTime? date, String format, {String? locale}) {
    if (date == null) return null;
    final formatter = DateFormat(format, locale);
    return formatter.format(date);
  }

  static DateTime? parseDate(String strDate, String format,
      {bool utc = false}) {
    try {
      return DateFormat(format).parse(strDate, utc);
    } catch (e) {
      return null;
    }
  }
}
