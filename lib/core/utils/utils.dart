import 'package:intl/intl.dart';

String humanDateFormat(DateTime date) {
  final dateFormatter = DateFormat("dd-MM-yyyy HH:mm");
  return dateFormatter.format(date);
}
