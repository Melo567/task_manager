import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get humanDateTime => DateFormat("dd-MM-yyyy HH:mm").format(this);

  String get humanDate => DateFormat("dd-MM-yyyy").format(this);

  String get humanTime => DateFormat("HH:mm").format(this);
}
