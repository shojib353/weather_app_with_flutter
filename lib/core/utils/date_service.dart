import 'package:intl/intl.dart';
String formatDate(String localtime) {
  try {
    DateTime date = DateTime.parse(localtime);  // Parse the string to DateTime
    // Format: Day of the week, Day Month Year (e.g., "Monday, 8 January 2025")
    return DateFormat('d MMMM, EEEE').format(date);
  } catch (e) {
    return 'Invalid Date';  // In case parsing fails
  }
}
