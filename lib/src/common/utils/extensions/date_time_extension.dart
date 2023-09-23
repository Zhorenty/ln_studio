import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String jsonFormat() => DateFormat('yyyy-MM-dd').format(this);

  String defaultFormat() => DateFormat('d MMMM y года').format(this);
}
