import 'package:intl/intl.dart';

extension DateTimeFormatted on DateTime {
  String getFormatedString(String format) => DateFormat(format).format(this);
}

extension StringEXT on String {
  DateTime? tryParse(String fromFormat, [bool utc = false]) {
    if (this.isNotEmpty) {
      return DateFormat(fromFormat).parse(this);
    }
  }
}
