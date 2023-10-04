import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String jsonFormat() => DateFormat('yyyy-MM-dd').format(this);

  String defaultFormat() => DateFormat('d MMM y').format(this);

  bool isAfterAsNow() {
    final now = DateTime.now();
    return DateUtils.isSameDay(this, now) || isAfter(now);
  }
}
