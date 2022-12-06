import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime, String pattern) {
  return DateFormat(pattern).format(dateTime);
}