import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dt) => DateFormat('EEE, d MMM').format(dt);
}
