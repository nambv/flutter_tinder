import 'package:json_annotation/json_annotation.dart';
import 'package:tinder/util/date_util.dart';

class DateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  static const serverDateTime = "yyyy-MM-dd\'T\'HH:mm:ss\'Z\'";

  const DateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    json = json.replaceAll(RegExp(r'\..\d+Z'), "Z");
    return DateUtil.parseDate(json, serverDateTime, utc: true)?.toLocal() ??
        DateTime.now();
  }

  @override
  dynamic toJson(DateTime? date) =>
      DateUtil.formatDate(date?.toUtc(), serverDateTime);
}
